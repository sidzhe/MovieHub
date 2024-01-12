//
//  Extension + String.swift
//  MovieHub
//
//  Created by sidzhe on 11.01.2024.
//

import Foundation

extension String {
    func localized() -> String {
        NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
