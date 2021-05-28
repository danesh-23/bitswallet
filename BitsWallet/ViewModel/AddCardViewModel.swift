//
//  AddCardViewModel.swift
//  BitsWallet
//
//  Created by Danesh Rajasolan on 2021-05-28.
//

import Foundation

class AddCardViewModel {
    var cardDetails: CardDetails!
    
    init(name: String, number: String, expiry: String, cvv: String) {
        let name = name.components(separatedBy: " ")
        cardDetails = CardDetails(number: number, firstName: name[0], lastName: name[1], expiryDate: expiry, cvvCode: cvv)
    }
    
    init() {
        cardDetails = CardDetails(number: "", firstName: "", lastName: "", expiryDate: "", cvvCode: "")
    }
    
    init(from card: CardDetails) {
        cardDetails = card
    }
    
    func validateData() -> Result<Bool, AlertError> {
        guard !cardDetails.firstName.isEmpty && !cardDetails.lastName.isEmpty else {
            return .failure(AlertError(title: ErrorMessage.invalidName.rawValue, message: "Please enter your full name", buttonTitle: "OK"))
        }
        
        guard !cardDetails.number.isEmpty && cardDetails.number.count == 16 else {
            return .failure(AlertError(title: ErrorMessage.invalidNumber.rawValue, message: "Please enter a valid card number", buttonTitle: "OK"))
        }
        
        let expirySplit = cardDetails.expiryDate.components(separatedBy: "/")
        guard !cardDetails.expiryDate.isEmpty && cardDetails.expiryDate.contains("/") && expirySplit[0].count <= 2 && expirySplit[1].count == 4 && expirySplit.count == 2 else {
            return .failure(AlertError(title: ErrorMessage.invalidExpiry.rawValue, message: "Please enter a valid date in the MM/YYYY format including the forward slash", buttonTitle: "OK"))
        }
        
        guard !cardDetails.cvvCode.isEmpty && cardDetails.cvvCode.count == 3 else {
            return .failure(AlertError(title: ErrorMessage.invalidCVV.rawValue, message: "Please enter a valid 3 digit CVV number that can be found on the back of your card", buttonTitle: "OK"))
        }
        return .success(true)
    }
}

struct AlertError: Error {
    var title: String
    var message: String
    var buttonTitle: String
}

enum ErrorMessage: String {
    case invalidName = "Invalid Full Name"
    case invalidNumber = "Invalid Card Number"
    case invalidExpiry = "Invalid Date Format"
    case invalidCVV = "Invalid CVV Number"
}
