//
//  CoordinatorProtocol.swift
//  BitsWallet
//
//  Created by Danesh Rajasolan on 2021-05-25.
//

import UIKit

protocol CoordinatorProtocol {
//    var childCoordinators: [CoordinatorProtocol] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
