//
//  CardCellViewModel.swift
//  BitsWallet
//
//  Created by Danesh Rajasolan on 2021-05-28.
//

import Foundation

class CardCellViewModel: Equatable {
    static func == (lhs: CardCellViewModel, rhs: CardCellViewModel) -> Bool {
        return lhs.cardNumber == rhs.cardNumber
    }
    
    var cardNumber: String!

    init(card: CardDetails) {
        self.cardNumber = card.number
    }
}
