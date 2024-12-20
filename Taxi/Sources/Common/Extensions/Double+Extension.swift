//
//  Double+Extension.swift
//  Taxi
//
//  Created by Dmitry Yastrebov on 20.12.2024.
//

import Foundation

extension Double {

    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }

    func toCurrency() -> String {
        currencyFormatter.string(for: self) ?? ""
    }
}
