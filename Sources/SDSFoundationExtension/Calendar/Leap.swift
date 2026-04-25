//
//  File.swift
//  SDSFoundationExtension
//
//  Created by Tomoaki Yagishita on 2026/04/25.
//

import Foundation

extension Calendar {
    public func isLeapYear(_ date: Date) -> Bool {
        let year = dateComponents([.year], from: date).year!
        return isLeapYear(year)
    }
    public func isLeapYear(_ year: Int) -> Bool {
        guard 0 <= year else { fatalError("unexpected input")}
        return  ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)
    }
}
