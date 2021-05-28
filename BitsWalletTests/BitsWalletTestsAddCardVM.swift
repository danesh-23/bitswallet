//
//  BitsWalletTestsAddCardVM.swift
//  BitsWalletTests
//
//  Created by Danesh Rajasolan on 2021-05-27.
//

import XCTest
@testable import BitsWallet

class BitsWalletTestsAddCardVM: XCTestCase {
    
    var sut: AddCardViewModel!
    var mockAPI: CardAPI!
    
    override func setUp() {
        super.setUp()
        sut = AddCardViewModel()
        mockAPI = CardAPI()
    }
    
    func testCorrectInitialisation() {
        let card = mockAPI.getCards(generate: 1)[0]
        sut = AddCardViewModel(from: card)
        
        XCTAssertTrue(sut.cardDetails == card)
    }
    
    func testCorrectValidationData() {
        let card = mockAPI.getCards(generate: 1)[0]
        sut = AddCardViewModel(from: card)
        let result = sut.validateData()
        
        switch result {
        case .success(_):
            XCTAssertTrue(true)
        default:
            XCTFail("Should be valid data")
        }
    }
    
    func testFailedNameValidation() {
        let card = CardAPI.incompleteNameCardDetails
        sut = AddCardViewModel(from: card)
        let result = sut.validateData()
        
        switch result {
        case .failure(let alert):
            XCTAssertTrue(alert.title == ErrorMessage.invalidName.rawValue)
        default:
            XCTFail("Should not validate data since invalid name")
        }
    }
    
    func testFailedNumberValidation() {
        let card = CardAPI.incompleteNumberCardDetails
        sut = AddCardViewModel(from: card)
        let result = sut.validateData()
        
        switch result {
        case .failure(let alert):
            XCTAssertTrue(alert.title == ErrorMessage.invalidNumber.rawValue)
        default:
            XCTFail("Should not validate data since invalid number")
        }
    }

    func testFailedExpiryValidation() {
        let card = CardAPI.incompleteExpiryCardDetails
        sut = AddCardViewModel(from: card)
        let result = sut.validateData()
        
        switch result {
        case .failure(let alert):
            print(alert)
            XCTAssertTrue(alert.title == ErrorMessage.invalidExpiry.rawValue)
        default:
            XCTFail("Should not validate data since invalid expiry date")
        }
    }

    func testFailedCVVValidation() {
        let card = CardAPI.incompleteCVVCardDetails
        sut = AddCardViewModel(from: card)
        let result = sut.validateData()
        
        switch result {
        case .failure(let alert):
            XCTAssertTrue(alert.title == ErrorMessage.invalidCVV.rawValue)
        default:
            XCTFail("Should not validate data since invalid cvv number")
        }
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        mockAPI = nil
    }
}
