//
//  BitsWalletTests.swift
//  BitsWalletTests
//
//  Created by Danesh Rajasolan on 2021-05-27.
//

import XCTest
@testable import BitsWallet

class BitsWalletTests: XCTestCase {
    var sut: CardTableViewModel!
    var mockAPI: CardAPI!

    override func setUp() {
        super.setUp()
        sut = CardTableViewModel()
        mockAPI = CardAPI()
    }
    
    func testInitialSetup() {
        XCTAssertTrue(sut.numberOfRows == 0)
        XCTAssertTrue(sut.numberOfSections == 1)
    }
    
    func testSingleLoadData() {
        let cards = mockAPI.getCards(generate: 1)
        sut.loadData(generatedService: cards)
        
        XCTAssertTrue(sut.numberOfRows == 1)
        XCTAssertTrue(sut.cardDetails(at: 0) == cards[0])
        XCTAssertTrue(sut.cardCell(at: 0) == CardCellViewModel(card: cards[0]))
    }
    
    func testFiveLoadedData() {
        let cards = mockAPI.getCards(generate: 5)
        sut.loadData(generatedService: cards)
        
        XCTAssertTrue(sut.numberOfRows == 5)
        XCTAssertTrue(sut.cardDetails(at: 0) == cards[0])
        XCTAssertTrue(sut.cardDetails(at: 1) == cards[1])
        XCTAssertTrue(sut.cardDetails(at: 2) == cards[2])
        XCTAssertTrue(sut.cardDetails(at: 3) == cards[3])
        XCTAssertTrue(sut.cardDetails(at: 4) == cards[4])
        
        XCTAssertTrue(sut.cardCell(at: 0) == CardCellViewModel(card: cards[0]))
        XCTAssertTrue(sut.cardCell(at: 1) == CardCellViewModel(card: cards[1]))
        XCTAssertTrue(sut.cardCell(at: 2) == CardCellViewModel(card: cards[2]))
        XCTAssertTrue(sut.cardCell(at: 3) == CardCellViewModel(card: cards[3]))
        XCTAssertTrue(sut.cardCell(at: 4) == CardCellViewModel(card: cards[4]))
    }
    
    func testAddingOneNewCard() {
        let card = mockAPI.getCards(generate: 1)[0]
        sut.addCard(card: card)
        
        XCTAssertTrue(sut.numberOfRows == 1)
        XCTAssertTrue(sut.cardDetails(at: 0) == card)
        XCTAssertTrue(sut.cardCell(at: 0) == CardCellViewModel(card: card))
    }
    
    func testAddingThreeNewCards() {
        let cards = mockAPI.getCards(generate: 3)
        sut.addCard(card: cards[0])
        sut.addCard(card: cards[1])
        sut.addCard(card: cards[2])

        XCTAssertTrue(sut.numberOfRows == 3)
        XCTAssertTrue(sut.cardDetails(at: 0) == cards[0])
        XCTAssertTrue(sut.cardDetails(at: 1) == cards[1])
        XCTAssertTrue(sut.cardDetails(at: 2) == cards[2])
        
        XCTAssertTrue(sut.cardCell(at: 0) == CardCellViewModel(card: cards[0]))
        XCTAssertTrue(sut.cardCell(at: 1) == CardCellViewModel(card: cards[1]))
        XCTAssertTrue(sut.cardCell(at: 2) == CardCellViewModel(card: cards[2]))
    }
    
    func testAddTwoNewCardsOnExistingTwoCards() {
        let cards = mockAPI.getCards(generate: 2)
        sut.loadData(generatedService: cards)
        
        let newCards = mockAPI.getCards(generate: 2)
        sut.addCard(card: newCards[0])
        sut.addCard(card: newCards[1])
        
        XCTAssertTrue(sut.numberOfRows == 4)
        XCTAssertTrue(sut.cardDetails(at: 0) == cards[0])
        XCTAssertTrue(sut.cardDetails(at: 1) == cards[1])
        XCTAssertTrue(sut.cardDetails(at: 2) == newCards[0])
        XCTAssertTrue(sut.cardDetails(at: 3) == newCards[1])
        
        XCTAssertTrue(sut.cardCell(at: 0) == CardCellViewModel(card: cards[0]))
        XCTAssertTrue(sut.cardCell(at: 1) == CardCellViewModel(card: cards[1]))
        XCTAssertTrue(sut.cardCell(at: 2) == CardCellViewModel(card: newCards[0]))
        XCTAssertTrue(sut.cardCell(at: 3) == CardCellViewModel(card: newCards[1]))
    }
    
    
}
