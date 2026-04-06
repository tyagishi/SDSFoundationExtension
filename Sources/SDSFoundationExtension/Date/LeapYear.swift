//
//  LeapYear.swift
//  SDSFoundationExtension
//
//  Created by Tomoaki Yagishita on 2026/04/06.
//

import Foundation

extension Int {
    public var isLeapYear: Bool {
        guard 0 <= self else { fatalError("unexpected input")}
        return  ((self % 4 == 0) && (self % 100 != 0)) || (self % 400 == 0)
    }
}

extension Date {
    public func isLeapYear(_ calendar: Calendar = .current) -> Bool {
        let year = calendar.dateComponents([.year], from: self).year!
        return year.isLeapYear
    }
}
