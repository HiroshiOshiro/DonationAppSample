//
//  DonationViewController.swift
//  TamBoon
//
//  Created by hiroshi on 2020/09/16.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class DonationViewController: UIViewController, NVActivityIndicatorViewable {

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var charityNameLabel: UILabel!
    @IBOutlet weak var charityLogoImageView: UIImageView!
    @IBOutlet weak var logoLoadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var expMonthTextField: UITextField!
    @IBOutlet weak var expYearTextField: UITextField!
    @IBOutlet weak var securityCodeTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    var charity: Charity?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // to enable scroll adjustment with keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        setupUI()
    }
    
    func setupUI() {
        charityNameLabel.text = charity?.name
        logoLoadingIndicator.startAnimating()
        if let logoURL = URL(string: charity?.logoUrl ?? "") {
            charityLogoImageView
                .loadImageAsynchronously(url: logoURL,
                                         completion: {(result) in
                                            if result {
                                                self.logoLoadingIndicator.stopAnimating()
                                            }
                })
        }
        
        validateInputForm()
    }
    
    
    @objc func keyboardWillShow(notification:NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification) {

        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    
    @IBAction func textEditingEnded(_ sender: Any) {
        validateInputForm()
    }
    
    // vary simple validation ;)
    func validateInputForm()  {
        if !(amountTextField.text?.isEmpty ?? true),
            !(nameTextField.text?.isEmpty ?? true),
            !(cardNumberTextField.text?.isEmpty ?? true),
            !(expMonthTextField.text?.isEmpty ?? true),
            !(expYearTextField.text?.isEmpty ?? true),
            !(securityCodeTextField.text?.isEmpty ?? true) {
            submitButton.isEnabled = true
        } else {
            submitButton.isEnabled = false
        }
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        guard let charity = self.charity
            , let amount = Int(amountTextField?.text ?? "")
            , let name = nameTextField.text
            else { return }
        
        // block user interaction
        startAnimating()
        
        // Need payment process but ommit
        let token = Date().description
        
        
        let donation = Donation(charityId: charity.id,
                                name:  name,
                                token: token,
                                amount: amount)
        
        APIAccess.postDonation(donation: donation, completion: {(result) in
            print(result.errorCode)
            // TODO toransition to result screen
            // resume user interaction
            self.stopAnimating()
            
            if let resultVC = R.storyboard.main.donationResultViewController() {
                resultVC.charity = self.charity
                resultVC.amount = amount
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(resultVC, animated: true)
                }
            }
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
