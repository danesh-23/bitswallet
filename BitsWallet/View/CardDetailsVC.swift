//
//  CardDetailsVC.swift
//  BitsWallet
//
//  Created by Danesh Rajasolan on 2021-05-26.
//

import UIKit

class CardDetailsVC: UIViewController {
    weak var coordinator: MainCoordinator?
    var cardDetailsVM: CardDetailsViewModel!
    
    init(card: CardDetails) {
        cardDetailsVM = CardDetailsViewModel(card: card)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var cardNumberLabel: UILabel = {
        let label = UILabel()
        label.accessibilityIdentifier = "cardNumberLabel"
        label.text = "Card Number"
        label.numberOfLines = 1
        label.font = UIFont(name: "Futura-Bold", size: 16)
        label.minimumScaleFactor = 0.5
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    lazy var cardHolderLabel: UILabel = {
        let label = UILabel()
        label.accessibilityIdentifier = "cardHolderLabel"
        label.text = "Card Holder"
        label.numberOfLines = 1
        label.font = UIFont(name: "Futura-Bold", size: 16)
        label.minimumScaleFactor = 0.5
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    lazy var expiryDateLabel: UILabel = {
        let label = UILabel()
        label.accessibilityIdentifier = "expiryDateLabel"
        label.text = "Expiry Date"
        label.numberOfLines = 1
        label.font = UIFont(name: "Futura-Bold", size: 16)
        label.minimumScaleFactor = 0.5
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    lazy var cardHolderField: UITextField = {
        let textField = UITextField()
        textField.accessibilityIdentifier = "cardHolderField"
        textField.isEnabled = false
        textField.attributedPlaceholder = NSAttributedString(string: cardDetailsVM.fullName, attributes: [NSAttributedString.Key.font: UIFont(name: "Futura-Medium", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.black])
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var cardNumber: UITextField = {
        let textField = UITextField()
        textField.accessibilityIdentifier = "cardNumber"
        textField.isEnabled = false
        textField.attributedPlaceholder = NSAttributedString(string: cardDetailsVM.cardNumber.formatCardNumber(), attributes: [NSAttributedString.Key.font: UIFont(name: "Futura-Medium", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.black])
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var expiryDate: UITextField = {
        let textField = UITextField()
        textField.accessibilityIdentifier = "expiryDate"
        textField.isEnabled = false
        textField.attributedPlaceholder = NSAttributedString(string: cardDetailsVM.expiryDate, attributes: [NSAttributedString.Key.font: UIFont(name: "Futura-Medium", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.black])
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        print(cardDetailsVM.cardNumber)
    }

    private func setupViews() {
        view.addSubview(expiryDateLabel)
        view.addSubview(cardNumberLabel)
        view.addSubview(cardHolderLabel)
        view.addSubview(cardHolderField)
        view.addSubview(cardNumber)
        view.addSubview(expiryDate)
        
        let leadingHolderLabelAnchor = cardHolderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        let trailingHolderLabelAnchor = cardHolderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        let topHolderLabelAnchor = cardHolderLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 30)
        
        let leadingHolderAnchor = cardHolderField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        let trailingHolderAnchor = cardHolderField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        let topHolderAnchor = cardHolderField.topAnchor.constraint(equalTo: cardHolderLabel.centerYAnchor, constant: 20)
        
        let leadingNumberLabelAnchor = cardNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        let trailingNumberLabelAnchor = cardNumberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        let topNumberLabelAnchor = cardNumberLabel.topAnchor.constraint(equalTo: cardHolderField.centerYAnchor, constant: 40)
        
        let leadingNumberAnchor = cardNumber.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        let trailingNumberAnchor = cardNumber.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        let topNumberAnchor = cardNumber.topAnchor.constraint(equalTo: cardNumberLabel.centerYAnchor, constant: 20)
        
        let leadingExpiryLabelAnchor = expiryDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        let trailingExpiryLabelAnchor = expiryDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        let topExpiryLabelAnchor = expiryDateLabel.topAnchor.constraint(equalTo: cardNumber.centerYAnchor, constant: 40)

        let leadingExpiryAnchor = expiryDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        let trailingExpiryAnchor = expiryDate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        let topExpiryAnchor = expiryDate.topAnchor.constraint(equalTo: expiryDateLabel.centerYAnchor, constant: 20)

        NSLayoutConstraint.activate([leadingHolderAnchor, leadingNumberAnchor, trailingHolderAnchor, trailingNumberAnchor, topHolderAnchor, topNumberAnchor, leadingExpiryAnchor, trailingExpiryAnchor, topExpiryAnchor, leadingHolderLabelAnchor, trailingHolderLabelAnchor, topHolderLabelAnchor, leadingNumberLabelAnchor, trailingNumberLabelAnchor, topNumberLabelAnchor, leadingExpiryLabelAnchor, trailingExpiryLabelAnchor, topExpiryLabelAnchor])
    }
}
