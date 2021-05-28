//
//  CardAPI.swift
//  BitsWallet
//
//  Created by Danesh Rajasolan on 2021-05-26.
//

import Foundation

class CardAPI {
    private var cardAPI: [CardDetails] = []
    
    private func cardGenerator(generate: Int) {
        for _ in 0..<generate {
            var number: String = ""
            for _ in 0..<4 {
                let random = Int.random(in: 1000...9999)
                number.append(random.description)
            }
            cardAPI.append(CardDetails(number: number, firstName: "Danesh", lastName: "Rajasolan", expiryDate: "\(Int.random(in: 1...12))/\(Int.random(in: 2021...2030))", cvvCode: "\(Int.random(in: 100...999))"))
        }
    }
    
    func getCards(generate: Int) -> [CardDetails] { cardGenerator(generate: generate); return cardAPI }
    
    static let incompleteNameCardDetails: CardDetails = CardDetails(number: "1234123412341234", firstName: "Danesh", lastName: "", expiryDate: "11/2025", cvvCode: "234")

    static let incompleteNumberCardDetails: CardDetails = CardDetails(number: "123412341234", firstName: "Danesh", lastName: "Rajasolan", expiryDate: "11/2025", cvvCode: "234")

    static let incompleteExpiryCardDetails: CardDetails = CardDetails(number: "1234123412341234", firstName: "Danesh", lastName: "Rajasolan", expiryDate: "12", cvvCode: "234")

    static let incompleteCVVCardDetails: CardDetails = CardDetails(number: "1234123412341234", firstName: "Danesh", lastName: "Rajasolan", expiryDate: "11/2025", cvvCode: "1")
}
