//
//  File.swift
//  SDSFoundationExtension
//
//  Created by Tomoaki Yagishita on 2025/04/14.
//

import Foundation

/// repeat frequency
public enum DateRepeatFrequency: String, RawRepresentable, Codable, CaseIterable, Sendable {
    case daily
    case monthly, biMonthly, quarterly, twiceAYear, yearly

    var inMonth: Int {
        switch self {
        case .daily:       return 0 // does not work for .daily
        case .monthly:
            return 1
        case .biMonthly:
            return 2
        case .quarterly:
            return 3
        case .twiceAYear:
            return 6
        case .yearly:
            return 12
        }
    }
}

/// date adjustment during date repating, note: for .daily, only noAdjustment works
public enum DateRepeatAdjustment: String, RawRepresentable, Codable, CaseIterable, Sendable {
    case noAdjustment, nextWorkingDay, prevWorkingDay, endOfMonth
}

extension Calendar {
    // swiftlint:disable:next cyclomatic_complexity function_body_length
    public func repeatDates(from startDate: Date, to endDate: Date,
                            frequency: DateRepeatFrequency, adjustment: DateRepeatAdjustment) -> [Date] {
        let startDateComp = Calendar.current.dateComponents(in: .current, from: startDate)
        
        let matchComponent: DateComponents
        switch frequency {
        case .yearly:
            matchComponent = DateComponents(month: startDateComp.month!, day: startDateComp.day!,
                                            hour: startDateComp.hour!, minute: startDateComp.minute!,
                                            second: startDateComp.second!)
        case .twiceAYear, .quarterly, .biMonthly, .monthly:
            matchComponent = DateComponents(day: startDateComp.day!,
                                            hour: startDateComp.hour!, minute: startDateComp.minute!,
                                            second: startDateComp.second!)
        case .daily:
            matchComponent = DateComponents(hour: startDateComp.hour!, minute: startDateComp.minute!,
                                            second: startDateComp.second!)
        }
        
        var retDates: [Date] = []
        if adjustment == .endOfMonth {
            retDates.append(endOfMonthWithSameHMS(startDate)!)
        } else {
            retDates.append(startDate)
        }
        
        switch frequency {
        case .yearly, .monthly:
            Calendar.current.enumerateDates(startingAfter: startDate,
                                            matching: matchComponent,
                                            matchingPolicy: .strict) { result, _, stop in
                guard let date = result else { return }
                if endDate < date { stop = true; return }
                
                if adjustment == .endOfMonth,
                   let eom = endOfMonthWithSameHMS(date) {
                    retDates.append(eom)
                } else {
                    if Calendar.current.isDateInWeekend(date) {
                        if adjustment == .nextWorkingDay,
                           let nwd = nextWorkingDay(date) {
                            retDates.append(nwd)
                        } else if adjustment == .prevWorkingDay,
                                  let pwd = prevWorkingDay(date) {
                            retDates.append(pwd)
                        } else {
                            retDates.append(date)
                        }
                    } else {
                        retDates.append(date)
                    }
                }
            }
        case .twiceAYear, .quarterly, .biMonthly:
            let addComp = DateComponents(month: frequency.inMonth)
            var currentDate = startDate
            while let nextDate = Calendar.current.date(byAdding: addComp, to: currentDate),
                  nextDate < endDate {
                if adjustment == .endOfMonth,
                   let eom = endOfMonthWithSameHMS(nextDate) {
                    retDates.append(eom)
                } else {
                    if Calendar.current.isDateInWeekend(nextDate) {
                        if adjustment == .nextWorkingDay,
                           let nwd = nextWorkingDay(nextDate) {
                            retDates.append(nwd)
                        } else if adjustment == .prevWorkingDay,
                                  let pwd = prevWorkingDay(nextDate) {
                            retDates.append(pwd)
                        } else {
                            retDates.append(nextDate)
                        }
                    } else {
                        retDates.append(nextDate)
                    }
                }
                currentDate = nextDate
            }
        case .daily:
            Calendar.current.enumerateDates(startingAfter: startDate,
                                            matching: matchComponent,
                                            matchingPolicy: .strict) { result, _, stop in
                guard let date = result else { return }
                if endDate < date { stop = true; return }
                retDates.append(date)
            }
        }
        
        return retDates
    }
    
    func startOfMonth(_ date: Date) -> Date? {
        return self.date(from: Calendar.current.dateComponents([.year, .month], from: date))
    }

    func endDayOfMonth(_ date: Date) -> Int {
        return 31
    }

    func endOfMonth(_ date: Date) -> Date? {
        guard let startOfMonth = startOfMonth(date) else { return nil }
        return self.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)
    }

    func endOfMonthWithSameHMS(_ date: Date) -> Date? {
        guard let eom = endOfMonth(date) else { return nil }
        let eomComp = dateComponents(in: .current, from: eom)
        
        var origDateComp = dateComponents(in: .current, from: date)
        origDateComp.day = eomComp.day

        return self.date(from: origDateComp)
    }

    func prevWorkingDay(_ date: Date) -> Date? {
        let dayInSecond: CGFloat = 60 * 60 * 24
        var nwd = date.advanced(by: dayInSecond * -1)
        while isDateInWeekend(nwd) {
            nwd = nwd.advanced(by: dayInSecond * -1)
        }
        return nwd    }
    func nextWorkingDay(_ date: Date) -> Date? {
        let dayInSecond: CGFloat = 60 * 60 * 24
        var nwd = date.advanced(by: dayInSecond)
        while isDateInWeekend(nwd) {
            nwd = nwd.advanced(by: dayInSecond)
        }
        return nwd
    }
}
