//
//  BitsWalletUITests.swift
//  BitsWalletUITests
//
//  Created by Danesh Rajasolan on 2021-05-28.
//

import XCTest

class BitsWalletUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
        continueAfterFailure = false
    }
    
    func testCardTableExists() {
        let cardTableView = app.tables["cardTable"]
        let addBarButtonItem = app.navigationBars.buttons["addBarButtonItem"]

        XCTAssertTrue(cardTableView.exists)
        XCTAssertTrue(addBarButtonItem.exists)
    }
    
    func testDetailViewExists() {
        let cardTableView = app.tables["cardTable"]
        cardTableView.cells.element(boundBy: Int.random(in: 0..<cardTableView.cells.count)).tap()
        
        let cardNumber = app.textFields["cardNumber"]
        let cardNumberLabel = app.staticTexts["cardHolderLabel"]
        let cardHolderField = app.textFields["cardHolderField"]
        let cardHolderLabel = app.staticTexts["cardHolderLabel"]
        let expiryDateLabel = app.staticTexts["expiryDateLabel"]
        let expiryDate = app.textFields["expiryDate"]

        XCTAssertTrue(cardNumber.exists)
        XCTAssertTrue(cardNumberLabel.exists)
        XCTAssertTrue(cardHolderField.exists)
        XCTAssertTrue(cardHolderLabel.exists)
        XCTAssertTrue(expiryDateLabel.exists)
        XCTAssertTrue(expiryDate.exists)
    }
    
    func testAddCardViewExists() {
        let addBarButtonItem = app.navigationBars.buttons["addBarButtonItem"]
        addBarButtonItem.tap()
        
        let cardHolderField = app.textFields["cardHolderField"]
        let cardNumber = app.textFields["cardNumber"]
        let expiryDate = app.textFields["expiryDate"]
        let cvvNumber = app.textFields["cvvNumber"]
        let cancelNavButton = app.navigationBars.buttons["cancelBarButtonItem"]
        let doneNavButton = app.navigationBars.buttons["doneBarButtonItem"]
        
        XCTAssertTrue(cardHolderField.exists)
        XCTAssertTrue(cardNumber.exists)
        XCTAssertTrue(expiryDate.exists)
        XCTAssertTrue(cvvNumber.exists)
        XCTAssertTrue(cancelNavButton.exists)
        XCTAssertTrue(doneNavButton.exists)
        
        XCTAssertTrue(cardHolderField.placeholderValue == "Cardholder Name")
        XCTAssertTrue(cardNumber.placeholderValue == "Card Number")
        XCTAssertTrue(expiryDate.placeholderValue == "Expiry Date")
        XCTAssertTrue(cvvNumber.placeholderValue == "CVV Code")
        XCTAssertTrue(cancelNavButton.label == "Cancel")
        XCTAssertTrue(doneNavButton.label == "Done")
    }
    
    func testAddedCardTableView() {
        let cardTable = app.tables["cardTable"]
        let count = cardTable.cells.count
        var cardNumbers: [String] = []
        
        for i in 0..<count {
            let cellLabel = cardTable.cells.element(matching: .cell, identifier: "cardTable_\(i)").label
            cardNumbers.append(cellLabel)
        }
        
        let addBarButtonItem = app.navigationBars.buttons["addBarButtonItem"]
        addBarButtonItem.tap()
        
        let cardHolderField = app.textFields["cardHolderField"]
        let cardNumber = app.textFields["cardNumber"]
        let expiryDate = app.textFields["expiryDate"]
        let cvvNumber = app.textFields["cvvNumber"]
        let doneNavButton = app.navigationBars.buttons["doneBarButtonItem"]
        
        let addedName = "John Doe"
        let addedNumber = "1234567890876543"
        let addedExpiry = "11/2022"
        let addedCVV = "521"

        cardHolderField.tap()
        cardHolderField.typeText(addedName)
        
        cardNumber.tap()
        cardNumber.typeText(addedNumber)
        
        expiryDate.tap()
        expiryDate.typeText(addedExpiry)
        
        cvvNumber.tap()
        cvvNumber.typeText(addedCVV)
        doneNavButton.tap()
        
        let addedCellLabel = cardTable.cells.element(boundBy: count).staticTexts["numberLabel"].label
        
        XCTAssertTrue(cardTable.exists)
        XCTAssertTrue(addedNumber == addedCellLabel.replacingOccurrences(of: " ", with: ""))
    }
    
    func testLoadFirstFiveCells() {
        let cardTable = app.tables["cardTable"]

        let promise = expectation(description: "Wait for test to run") // mimic the wait for an api to load actual data
        let count: Int = cardTable.cells.count

        for i in 0..<count {
            let cell = cardTable.cells.element(matching: .cell, identifier: "cardTable_\(i)")
            XCTAssertTrue(cell.exists)
            cell.tap()
            
            if i == count - 1 - 1 {
                promise.fulfill()
            }
            app.navigationBars.buttons.element(boundBy: 0).tap()
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertTrue(count == 5)
    }
    
    func testRandomlyClickedCellMatchDetails() {
        let cardHolderNameTemplate = "Danesh Rajasolan"
        
        let cardTable = app.tables["cardTable"]
        let cell = cardTable.cells.element(boundBy: Int.random(in: 0..<cardTable.cells.count))
        let cardLabelText = cell.staticTexts["numberLabel"].label
        cell.tap()
        
         let cardNumber = app.textFields["cardNumber"]
        let cardHolder = app.textFields["cardHolderField"]
        let expiryDate = app.textFields["expiryDate"]

        XCTAssertTrue(cardLabelText == (cardNumber.value as! String))
        XCTAssertTrue((cardNumber.value as! String).count == 19)
        
        XCTAssertTrue((cardHolder.value as! String) == cardHolderNameTemplate)

        XCTAssertTrue((expiryDate.value as! String).contains("/"))
    }
    
    func testAllEmptyFieldsInAddCardView() {
        let addBarButtonItem = app.navigationBars.buttons["addBarButtonItem"]
        addBarButtonItem.tap()
        
        let doneNavButton = app.navigationBars.buttons["doneBarButtonItem"]
        
        doneNavButton.tap()
        
        let alertQuery = app.alerts["alert"].scrollViews.otherElements
        XCTAssertTrue(alertQuery.staticTexts["Invalid Full Name"].exists)
        XCTAssertTrue(alertQuery.staticTexts["Please enter your full name"].exists)
    }
    
    func testInvalidNameInAddCardView() {
        let addBarButtonItem = app.navigationBars.buttons["addBarButtonItem"]
        addBarButtonItem.tap()
        
        let cardHolderField = app.textFields["cardHolderField"]
        let doneNavButton = app.navigationBars.buttons["doneBarButtonItem"]
        
        cardHolderField.tap()
        cardHolderField.typeText("MissingLastName")
        doneNavButton.tap()
        
        let alertQuery = app.alerts["alert"].scrollViews.otherElements
        XCTAssertTrue(alertQuery.staticTexts["Invalid Full Name"].exists)
        XCTAssertTrue(alertQuery.staticTexts["Please enter your full name"].exists)
    }
    
    func testInvalidNumberInAddCardView() {
        let addBarButtonItem = app.navigationBars.buttons["addBarButtonItem"]
        addBarButtonItem.tap()
        
        let cardNumber = app.textFields["cardNumber"]
        let cardHolderField = app.textFields["cardHolderField"]
        let doneNavButton = app.navigationBars.buttons["doneBarButtonItem"]
        
        cardHolderField.tap()
        cardHolderField.typeText("Danesh Rajasolan")
        
        cardNumber.tap()
        cardNumber.typeText("12345678")
        doneNavButton.tap()
        
        let alertQuery = app.alerts["alert"].scrollViews.otherElements
        XCTAssertTrue(alertQuery.staticTexts["Invalid Card Number"].exists)
        XCTAssertTrue(alertQuery.staticTexts["Please enter a valid card number"].exists)
    }
    
    func testInvalidExpiryDateInAddCardView() {
        let addBarButtonItem = app.navigationBars.buttons["addBarButtonItem"]
        addBarButtonItem.tap()
        
        let cardNumber = app.textFields["cardNumber"]
        let cardHolderField = app.textFields["cardHolderField"]
        let expiryDate = app.textFields["expiryDate"]
        let doneNavButton = app.navigationBars.buttons["doneBarButtonItem"]
        
        cardHolderField.tap()
        cardHolderField.typeText("Danesh Rajasolan")
        
        cardNumber.tap()
        cardNumber.typeText("1234567890123456")
        
        expiryDate.tap()
        expiryDate.typeText("1234")
        doneNavButton.tap()
        
        let alertQuery = app.alerts["alert"].scrollViews.otherElements
        XCTAssertTrue(alertQuery.staticTexts["Invalid Date Format"].exists)
        XCTAssertTrue(alertQuery.staticTexts["Please enter a valid date in the MM/YYYY format including the forward slash"].exists)
    }
    
    func testInvalidCVVInAddCardView() {
        let addBarButtonItem = app.navigationBars.buttons["addBarButtonItem"]
        addBarButtonItem.tap()
        
        let cardNumber = app.textFields["cardNumber"]
        let cardHolderField = app.textFields["cardHolderField"]
        let expiryDate = app.textFields["expiryDate"]
        let cvvNumber = app.textFields["cvvNumber"]
        let doneNavButton = app.navigationBars.buttons["doneBarButtonItem"]
        
        cardHolderField.tap()
        cardHolderField.typeText("Danesh Rajasolan")
        
        cardNumber.tap()
        cardNumber.typeText("1234567890123456")
        
        expiryDate.tap()
        expiryDate.typeText("12/2024")
        
        cvvNumber.tap()
        cvvNumber.typeText("1")
        doneNavButton.tap()

        let alertQuery = app.alerts["alert"].scrollViews.otherElements
        XCTAssertTrue(alertQuery.staticTexts["Invalid CVV Number"].exists)
        XCTAssertTrue(alertQuery.staticTexts["Please enter a valid 3 digit CVV number that can be found on the back of your card"].exists)
    }
}
