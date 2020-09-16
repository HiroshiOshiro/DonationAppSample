//
//  Charity.swift
//  TamBoon
//
//  Created by hiroshi on 2020/09/16.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import Foundation

class Charity: Codable {
    let id: Int
    let name: String
    let logoUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case logoUrl = "logo_url"
    }
}
