//
//  Utility.swift
//  TamBoon
//
//  Created by hiroshi on 2020/09/21.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import UIKit

class Utility {
    
    /// show alert with single dissmiss button
    class func showAlertWithDismiss(viewController: UIViewController, title: String?, message: String?, dismissText: String? = "OK", completion: (() -> Void)?) {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: dismissText, style: .default, handler: nil)
        alert.addAction(defaultAction)
        viewController.present(alert, animated: true, completion: completion)
    }
}
