//
//  DonationResultViewController.swift
//  TamBoon
//
//  Created by hiroshi on 2020/09/16.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import UIKit

class DonationResultViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    var charity: Charity?
    var amount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        // hide navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        messageLabel.text = R.string.localizable.donationResultText(charity?.name ?? "")
        
        // format amount with comma
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        amountLabel.text = R.string.localizable.donationResultAmount(numberFormatter.string(from: NSNumber(value:amount)) ?? "")
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
