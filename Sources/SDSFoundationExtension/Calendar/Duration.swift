//
//  Duration.swift
//  SDSFoundationExtension
//
//  Created by Tomoaki Yagishita on 2026/04/25.
//

import Foundation

extension Calendar {
    @available(macOS 13, iOS 16, tvOS 16, watchOS 9,*)
    public func duration(years: Int, from start: Date) -> Duration {
        guard let end = self.date(byAdding: DateComponents(year: years), to: start),
              let days = dateComponents([.day], from: start, to: end).day else { fatalError("error in calendar") }
        return Duration.days(Double(days))
    }
    @available(macOS 13, iOS 16, tvOS 16, watchOS 9,*)
    public func duration(months: Int, from start: Date) -> Duration {
        guard let end = self.date(byAdding: DateComponents(month: months), to: start),
              let days = dateComponents([.day], from: start, to: end).day else { fatalError("error in calendar") }
        return Duration.days(Double(days))
    }
}
