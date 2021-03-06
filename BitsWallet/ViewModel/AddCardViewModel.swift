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
        cardDetails = CardDetails(number: number, firstName: name[0], lastName: name.count == 1 ? "" : name[1], expiryDate: expiry, cvvCode: cvv)
    }
    
    init() {
        cardDetails = CardDetails(number: "", firstName: "", lastName: "", expiryDate: "", cvvCode: "")
    }
    
    init(from card: CardDetails) {
        cardDetails = card
    }
    
    static func validateData(name: String, number: String, expiry: String, cvv: String) -> Result<Bool, AlertError> {
        let name = name.components(separatedBy: " ")

        guard name.count == 2 else {
            return .failure(AlertError(title: ErrorMessage.invalidName.rawValue, message: "Please enter your full name", buttonTitle: "OK"))
        }
        
        guard number.count == 16 else {
            return .failure(AlertError(title: ErrorMessage.invalidNumber.rawValue, message: "Please enter a valid card number", buttonTitle: "OK"))
        }
        
        let expirySplit = expiry.components(separatedBy: "/")
        guard expiry.contains("/") && expirySplit[0].count <= 2 && expirySplit[1].count == 4 && expirySplit.count == 2 else {
            return .failure(AlertError(title: ErrorMessage.invalidExpiry.rawValue, message: "Please enter a valid date in the MM/YYYY format including the forward slash", buttonTitle: "OK"))
        }
        
        guard cvv.count == 3 else {
            return .failure(AlertError(title: ErrorMessage.invalidCVV.rawValue, message: "Please enter a valid 3 digit CVV number that can be found on the back of your card", buttonTitle: "OK"))
        }
        return .success(true)
    }
    
    func validateData(name: String, number: String, expiry: String, cvv: String) -> Result<Bool, AlertError> {
        let name = name.components(separatedBy: " ")

        guard name.count == 2 else {
            return .failure(AlertError(title: ErrorMessage.invalidName.rawValue, message: "Please enter your full name", buttonTitle: "OK"))
        }
        
        guard number.count == 16 else {
            return .failure(AlertError(title: ErrorMessage.invalidNumber.rawValue, message: "Please enter a valid card number", buttonTitle: "OK"))
        }
        
        let expirySplit = expiry.components(separatedBy: "/")
        guard expiry.contains("/") && expirySplit[0].count <= 2 && expirySplit[1].count == 4 && expirySplit.count == 2 else {
            return .failure(AlertError(title: ErrorMessage.invalidExpiry.rawValue, message: "Please enter a valid date in the MM/YYYY format including the forward slash", buttonTitle: "OK"))
        }
        
        guard cvv.count == 3 else {
            return .failure(AlertError(title: ErrorMessage.invalidCVV.rawValue, message: "Please enter a valid 3 digit CVV number that can be found on the back of your card", buttonTitle: "OK"))
        }
        return .success(true)
    }
    
    func validateData() -> Result<Bool, AlertError> {
        guard !cardDetails.lastName.isEmpty else {
            return .failure(AlertError(title: ErrorMessage.invalidName.rawValue, message: "Please enter your full name", buttonTitle: "OK"))
        }
        
        guard cardDetails.number.count == 16 else {
            return .failure(AlertError(title: ErrorMessage.invalidNumber.rawValue, message: "Please enter a valid card number", buttonTitle: "OK"))
        }
        
        let expirySplit = cardDetails.expiryDate.components(separatedBy: "/")
        guard cardDetails.expiryDate.contains("/") && expirySplit[0].count <= 2 && expirySplit[1].count == 4 && expirySplit.count == 2 else {
            return .failure(AlertError(title: ErrorMessage.invalidExpiry.rawValue, message: "Please enter a valid date in the MM/YYYY format including the forward slash", buttonTitle: "OK"))
        }
        
        guard cardDetails.cvvCode.count == 3 else {
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
