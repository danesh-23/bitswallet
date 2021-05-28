//
//  AddCardVC.swift
//  BitsWallet
//
//  Created by Danesh Rajasolan on 2021-05-26.
//

import UIKit

protocol AddCardDelegate {
    func addNewCard(card: AddCardViewModel)
}

class AddCardVC: UIViewController {
    weak var coordinator: MainCoordinator?
    var delegate: AddCardDelegate?
    var addCardVM: AddCardViewModel!
    
    var cardHolderField: UITextField = {
        let textField = UITextField()
        textField.accessibilityIdentifier = "cardHolderField"
        textField.keyboardType = .alphabet
        textField.autocapitalizationType = .words
        textField.attributedPlaceholder = NSAttributedString(string: "Cardholder Name", attributes: [NSAttributedString.Key.font: UIFont(name: "Futura-Medium", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.textColor = .white
        textField.backgroundColor = .black
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    var cardNumber: UITextField = {
        let textField = UITextField()
        textField.accessibilityIdentifier = "cardNumber"
        textField.keyboardType = .numberPad
        textField.attributedPlaceholder = NSAttributedString(string: "Card Number", attributes: [NSAttributedString.Key.font: UIFont(name: "Futura-Medium", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.textColor = .white
        textField.backgroundColor = .black
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    var expiryDate: UITextField = {
        let textField = UITextField()
        textField.accessibilityIdentifier = "expiryDate"
        textField.keyboardType = .asciiCapable
        textField.attributedPlaceholder = NSAttributedString(string: "Expiry Date", attributes: [NSAttributedString.Key.font: UIFont(name: "Futura-Medium", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.textColor = .white
        textField.backgroundColor = .black
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    var cvvNumber: UITextField = {
        let textField = UITextField()
        textField.accessibilityIdentifier = "cvvNumber"
        textField.keyboardType = .numberPad
        textField.attributedPlaceholder = NSAttributedString(string: "CVV Code", attributes: [NSAttributedString.Key.font: UIFont(name: "Futura-Medium", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.textColor = .white
        textField.backgroundColor = .black
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    var horizontalStack: UIStackView = {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.alignment = .center
        hStack.distribution = .equalSpacing
        hStack.translatesAutoresizingMaskIntoConstraints = false
        
        return hStack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        navigationItem.hidesBackButton = true
        
        let cancelBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissController))
        cancelBarButtonItem.accessibilityIdentifier = "cancelBarButtonItem"
        let doneBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(addNewCard))
        doneBarButtonItem.accessibilityIdentifier = "doneBarButtonItem"
        
        navigationItem.leftBarButtonItem = cancelBarButtonItem
        navigationItem.rightBarButtonItem = doneBarButtonItem
        hideKeyboardWhenTappedOutsideSearch()
        setupViews()
    }
    
    @objc func dismissController() {
        coordinator?.popCurrentController()
    }
    
    @objc func addNewCard() {
        switch AddCardViewModel.validateData(name: cardHolderField.text!, number: cardNumber.text!, expiry: expiryDate.text!, cvv: cvvNumber.text!) {
        case .success(_):
            addCardVM = AddCardViewModel(name: cardHolderField.text!, number: cardNumber.text!, expiry: expiryDate.text!, cvv: cvvNumber.text!)
            delegate?.addNewCard(card: addCardVM)
            coordinator?.popCurrentController()
        case .failure(let alertMessage):
            showAlert(title: alertMessage.title, message: alertMessage.message, buttonTitle: alertMessage.buttonTitle, completion: nil)
        }
    }
    
    private func setupViews() {
        view.addSubview(cardHolderField)
        view.addSubview(cardNumber)
        view.addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(expiryDate)
        horizontalStack.addArrangedSubview(cvvNumber)
        
        
        let leadingHolderAnchor = cardHolderField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        let trailingHolderAnchor = cardHolderField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        let topHolderAnchor = cardHolderField.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 30)
        
        let leadingNumberAnchor = cardNumber.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        let trailingNumberAnchor = cardNumber.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        let topNumberAnchor = cardNumber.topAnchor.constraint(equalTo: cardHolderField.topAnchor, constant: 60)
        
        let leadingStackAnchor = horizontalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        let trailingStackAnchor = horizontalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        let topStackAnchor = horizontalStack.topAnchor.constraint(equalTo: cardNumber.topAnchor, constant: 60)
        
        NSLayoutConstraint.activate([leadingStackAnchor, leadingHolderAnchor, leadingNumberAnchor, trailingStackAnchor, trailingHolderAnchor, trailingNumberAnchor, topStackAnchor, topHolderAnchor, topNumberAnchor])
    }
}
