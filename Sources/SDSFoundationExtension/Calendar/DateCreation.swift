//
//  DateCreation.swift
//  SDSFoundationExtension
//
//  Created by Tomoaki Yagishita on 2024/12/02.
//

import Foundation

extension Calendar {
    public func date(_ year: Int,_ month: Int,_ day: Int = 1, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date {
        return date(from: DateComponents(year: year, month: month, day: day, hour: hour, minute: minute, second: second))!
    }
    public func yearStartEnd(of year: Int) -> (start: Date, end: Date) {
        return (start: date(year, 1),
                end: date(year, 12, 31, hour: 23, minute: 59, second: 59))
    }
    public func yearRange(of year: Int) -> Range<Date> {
        date(year, 1)..<date(year+1,1)
    }
    
    public func monthStartEnd(_ ref: Date = Date()) -> (start: Date, end: Date) {
        var dateComp = self.dateComponents([.year, .month], from: ref)
        dateComp.day = 1
        dateComp.hour = 0
        dateComp.minute = 0
        dateComp.second = 0
        let start = date(from: dateComp)!
        let end = self.date(byAdding: .month, value: 1, to: start)!.advanced(by: -1)
        return (start, end)
    }
    // for convenience
    public func year(_ date: Date) -> Int {
        return self.dateComponents([.year], from: date).year!
    }
}
