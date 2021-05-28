//
//  CardTableViewModel.swift
//  BitsWallet
//
//  Created by Danesh Rajasolan on 2021-05-25.
//

import Foundation

class CardTableViewModel {
    private var cardCells: [CardDetails] = []
    var refreshClosure: (() -> ())?

    var numberOfRows: Int {
        return cardCells.count
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    func loadData(generate: Int = 5, generatedService: [CardDetails]? = nil) {
        if let cards = generatedService {
            cardCells.append(contentsOf: cards)
        } else {
            let cards = CardAPI().getCards(generate: generate)
            cardCells.append(contentsOf: cards)
        }
        guard let refreshClosure = refreshClosure else { return }
        refreshClosure()
    }
    
    func cardCell(at row: Int) -> CardCellViewModel {
        return CardCellViewModel(card: cardCells[row])
    }
    
    func cardDetails(at row: Int) -> CardDetails {
        return cardCells[row]
    }
    
    func addCard(card: CardDetails) {
        cardCells.append(card)
        guard let refreshClosure = refreshClosure else { return }
        refreshClosure()
    }
}
