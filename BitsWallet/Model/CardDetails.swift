//
//  CardDetails.swift
//  BitsWallet
//
//  Created by Danesh Rajasolan on 2021-05-25.
//

import Foundation

struct CardDetails: Codable, Equatable {
    let number: String
    let firstName: String
    let lastName: String
    let expiryDate: String
    let cvvCode: String
}
