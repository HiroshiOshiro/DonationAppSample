//
//  Donation.swift
//  TamBoon
//
//  Created by hiroshi on 2020/09/16.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import Foundation

class Donation: Codable {
    var charityId: Int
    var name: String
    var token: String
    var amount: Int
    
    init(charityId: Int, name: String, token: String, amount: Int) {
        self.charityId = charityId
        self.name = name
        self.token = token
        self.amount = amount
    }
}
