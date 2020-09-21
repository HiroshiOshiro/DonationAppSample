//
//  UIImageView+AsyncLoad.swift
//  TamBoon
//
//  Created by hiroshi on 2020/09/19.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import UIKit

extension UIImageView {
    
    /// load image asynchronously
    func loadImageAsynchronously(url: URL?, completion: ((_ result: Bool) -> Void)? = nil) {
        
        if url == nil {
            return
        }
        
        DispatchQueue.global().async {
            do {
                let imageData: Data? = try Data(contentsOf: url!)
                DispatchQueue.main.async {
                    if let data = imageData {
                        self.image = UIImage(data: data)
                        completion?(true)
                    } else {
                        print("image data is nil!")
                        completion?(false)
                    }
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
}
