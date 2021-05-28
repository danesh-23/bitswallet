//
//  UIViewController+Extensions.swift
//  BitsWallet
//
//  Created by Danesh Rajasolan on 2021-05-27.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedOutsideSearch() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showAlert(title: String, message: String, buttonTitle: String, completion: ((UIAlertAction) -> Void)?) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionButton = UIAlertAction(title: buttonTitle, style: .default, handler: completion)
        alertVC.addAction(actionButton)
        self.present(alertVC, animated: true, completion: nil)
    }
}
