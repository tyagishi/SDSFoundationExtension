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
}
