//
//  String+Extensions.swift
//  BitsWallet
//
//  Created by Danesh Rajasolan on 2021-05-27.
//

import Foundation

extension String {
    func formatCardNumber() -> String {
        let formatted = String(self.enumerated().map { $0 > 0 && $0 % 4 == 0 ? [" ", $1] : [$1]}.joined())
        return formatted
    }
}
