//
//  CardDetailsViewModel.swift
//  BitsWallet
//
//  Created by Danesh Rajasolan on 2021-05-28.
//

import Foundation

class CardDetailsViewModel {
    
    var fullName: String
    var cardNumber: String
    var expiryDate: String

    init(card: CardDetails) {
        fullName = card.firstName + " " + card.lastName
        cardNumber = card.number
        expiryDate = card.expiryDate
    }
}
