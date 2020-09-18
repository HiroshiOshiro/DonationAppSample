//
//  DonationResult.swift
//  TamBoon
//
//  Created by hiroshi on 2020/09/17.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import Foundation

class DonationResult: Codable {
    var success: Bool
    var errorCode: String
    var errorMessage: String
    
    private enum CodingKeys: String, CodingKey {
        case success
        case errorCode = "error_code"
        case errorMessage = "error_message"
    }
}
