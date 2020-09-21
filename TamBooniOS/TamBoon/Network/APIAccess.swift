//
//  APIAccess.swift
//  TamBoon
//
//  Created by hiroshi on 2020/09/16.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import Foundation

class APIAccess {
    
    static private let baseURL = "https://virtserver.swaggerhub.com/chakritw/tamboon-api/1.0.0/"
    static private let pathForCharity = "charities"
    static private let pathForDonation = "donations"
    
    static func getCharities(completion: @escaping (CharityList?) -> Void) {
        guard let url = URL(string: baseURL + pathForCharity) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // check error
            if let e = error {
                print(e.localizedDescription)
                return
            }
            // check response
            if let r = response as? HTTPURLResponse,
                r.statusCode == 200,
                let d = data {
                let decoder = JSONDecoder()
                do {
                    let charityList = try decoder.decode(CharityList.self, from: d)
                    completion(charityList)
                } catch {
                    print("error: ", error.localizedDescription)
                }
            } else {
                print(error?.localizedDescription ?? "Error")
                completion(nil)
            }
        }
        task.resume()
    }
    
    static func postDonation(donation: Donation, completion: @escaping (DonationResult?) -> Void) {
        guard let url = URL(string: baseURL + pathForDonation),
            let data = try? JSONEncoder().encode(donation) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let e = error {
                print(e.localizedDescription)
                return
            }
            
            if let r = response as? HTTPURLResponse,
                (r.statusCode == 200 || r.statusCode == 201),
                let d = data {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(DonationResult.self, from: d)
                    completion(result)
                } catch {
                    print("error: ", error.localizedDescription)
                }
            } else {
                print(error?.localizedDescription ?? "Error")
                completion(nil)
            }
        }
        task.resume()
    }
}
