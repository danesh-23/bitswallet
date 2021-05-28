//
//  MainCoordinator.swift
//  BitsWallet
//
//  Created by Danesh Rajasolan on 2021-05-25.
//

import UIKit

class MainCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = CardTableVC()
        vc.title = "BitsWallet"
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func addCard(controller: AddCardDelegate) {
        let vc = AddCardVC()
        vc.delegate = controller
        vc.title = "Add Card"
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openCardDetails(card: CardDetails) {
        let vc = CardDetailsVC(card: card)
        vc.title = "Card Details"
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func popCurrentController() {
        navigationController.popViewController(animated: true)
    }
}
