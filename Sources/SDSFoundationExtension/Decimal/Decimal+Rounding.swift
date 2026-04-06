//
//  Decimal+Rounding.swift
//  SDSFoundationExtension
//
//  Created by Tomoaki Yagishita on 2026/04/06.
//

import Foundation

extension Decimal {
    public func rounding(_ behavior: NSDecimalNumberHandler) -> Decimal {
        ((self as NSDecimalNumber).rounding(accordingToBehavior: behavior)) as Decimal
    }
}

extension NSDecimalNumberHandler {
    public convenience init(roundingMode: NSDecimalNumber.RoundingMode, scale: Int16) {
        self.init(roundingMode: roundingMode, scale: scale,
                  raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)
    }
    public static let plain = NSDecimalNumberHandler(roundingMode: .plain, scale: 0)
    public static let up = NSDecimalNumberHandler(roundingMode: .up, scale: 0)
    public static let down = NSDecimalNumberHandler(roundingMode: .down, scale: 0)
    public static let bankers = NSDecimalNumberHandler(roundingMode: .bankers, scale: 0)
}
