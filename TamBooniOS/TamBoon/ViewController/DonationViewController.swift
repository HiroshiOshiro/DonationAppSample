//
//  DonationViewController.swift
//  TamBoon
//
//  Created by hiroshi on 2020/09/16.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import UIKit

class DonationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let donation = Donation(name: "test", token: "token", amount: 123)
//        APIAccess.postDonation(donation: donation, completion: {(result) in
//            print(result.errorCode)
//        })
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
