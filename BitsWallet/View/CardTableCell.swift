//
//  CardTableCell.swift
//  BitsWallet
//
//  Created by Danesh Rajasolan on 2021-05-26.
//

import UIKit

class CardTableCell: UITableViewCell {
    static let identifier = "CardCell"

    func configureCell(card: CardCellViewModel) {
        let labelText = card.cardNumber.formatCardNumber()
        cardNumberLabel.text = labelText
    }
    
    var cardNumberLabel: UILabel = {
        let label = UILabel()
        label.accessibilityIdentifier = "numberLabel"
        label.numberOfLines = 1
        label.font = UIFont(name: "Futura-Bold", size: 16)
        label.minimumScaleFactor = 0.5
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cardNumberLabel)
        contentView.backgroundColor = .black
        
        let centerXAnchor = cardNumberLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        let centerYAnchor = cardNumberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        
        NSLayoutConstraint.activate([centerXAnchor, centerYAnchor])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
