//
//  File.swift
//
//  Created by : Tomoaki Yagishita on 2024/08/11
//  © 2024  SmallDeskSoftware
//

import Foundation

extension Calendar.Component {
    var unitInterval: CGFloat? {
        switch self {
        case .second:   return 1
        case .minute:   return 60
        case .hour:     return 3600
        case .day:      return 86400
        default: return nil
        }
    }

    var upperUnit: Calendar.Component? {
        switch self {
        case .month:  return .year
        case .day:    return .month
        case .hour:   return .day
        case .minute: return .hour
        case .second: return .minute
        case .nanosecond: return .second
        default: return nil
        }
    }
    
    var upperUnits: [Calendar.Component] {
        switch self {
        case .year:   return []
        case .month:  return [.year]
        case .day:    return [.year, .month]
        case .hour:   return [.year, .month, .day]
        case .minute: return [.year, .month, .day, .hour]
        case .second: return [.year, .month, .day, .hour, .minute]
        case .nanosecond: return [.year, .month, .day, .hour, .minute, .second]
        default: return []
        }
    }
    var aboveUnits: [Calendar.Component] {
        switch self {
        case .year:   return [.year]
        case .month:  return [.year, .month]
        case .day:    return [.year, .month, .day]
        case .hour:   return [.year, .month, .day, .hour]
        case .minute: return [.year, .month, .day, .hour, .minute]
        case .second: return [.year, .month, .day, .hour, .minute, .second]
        case .nanosecond: return [.year, .month, .day, .hour, .minute, .second, .nanosecond]
        default: return []
        }
    }
}

extension DateComponents {
    subscript(comp: Calendar.Component) -> Int? {
        switch comp {
        case .era:    return self.era
        case .year:   return self.year
        case .month:  return self.month
        case .day:    return self.day
        case .hour:   return self.hour
        case .minute: return self.minute
        case .second: return self.second
        case .weekday: return self.weekday
        case .weekdayOrdinal: return self.weekdayOrdinal
        case .quarter: return self.quarter
        case .weekOfMonth: return self.weekOfMonth
        case .weekOfYear: return self.weekOfYear
        case .yearForWeekOfYear: return self.yearForWeekOfYear
        case .nanosecond: return self.nanosecond
        //        case .dayOfYear:
        //            if #available(macOS 15, *) { return self.dayOfYear
        //            } else { return nil }
        default: return nil
        }
    }
    func firstValue(for comp: Calendar.Component ) -> Int? {
        switch comp {
        case .month:  return 1
        case .day:    return 1
        case .hour:   return 0
        case .minute: return 0
        case .second: return 0
        default: return nil
        }
    }

    func lastValue(for comp: Calendar.Component, in cal: Calendar) -> Int? {
        switch comp {
        case .month:  return 12
        case .day:
            guard let date = cal.date(from: self),
                  let days = cal.range(of: .day, in: .month, for: date) else { return nil }
            return days.count
        case .hour:   return 23
        case .minute: return 59
        case .second: return 59
        default: return nil
        }
    }
}

extension Calendar {
    /// calc start of the given date (with specified granurarity)
    /// start of date:
    /// (2024/01/12, 9:45:15, .second) -> 2024/01/12, 9:45:00
    /// (2024/01/12, 9:45:15, .minute) -> 2024/01/12, 9:00:00
    /// (2024/01/12, 9:45:15, .hour) -> 2024/01/12, 00:00:00
    /// (2024/01/12, 9:45:15, .day) -> 2024/01/01, 00:00:00
    /// (2024/01/12, 9:45:15, .month) -> 2024/01/01, 00:00:00
    public func start(of date: Date, adjustGranurarity lastComp: Calendar.Component) -> Date? {
        let comps = self.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let keepComps = lastComp.upperUnits
        guard !keepComps.isEmpty else { return nil }

        let newComps = DateComponents(year: keepComps.contains(.year) ? comps.year : comps.firstValue(for: .year),
                                      month: keepComps.contains(.month) ? comps.month : comps.firstValue(for: .month),
                                      day: keepComps.contains(.day) ? comps.day : comps.firstValue(for: .day),
                                      hour: keepComps.contains(.hour) ? comps.hour : comps.firstValue(for: .hour),
                                      minute: keepComps.contains(.minute) ? comps.minute : comps.firstValue(for: .minute),
                                      second: keepComps.contains(.second) ? comps.second : comps.firstValue(for: .second))
        return self.date(from: newComps)
    }
    
    // weekday comes from DateComponent i.e. 1:Sunday, 2:Monday, ... 7: Saturday
    public func startOf(weekday: Int, from date: Date) -> Date? {
        var calcDate: Date? = nil
        Calendar.current.enumerateDates(startingAfter: date, matching: .init(hour: 0, minute: 0, second: 0, weekday: weekday), matchingPolicy: .nextTime,
                                        direction: .backward,
                                        using: { (date, bool, stop) in
            calcDate = date
            stop = true
        })
        return calcDate
    }

    /// calc end of the given date (with specified granurarity)
    /// end of date
    /// (2024/01/12, 9:45:15, .second) -> 2024/01/12, 9:45:59
    /// (2024/01/12, 9:45:15, .minute) -> 2024/01/12, 9:59:59
    /// (2024/01/12, 9:45:15, .hour) -> 2024/01/12, 23:59:59
    /// (2024/01/12, 9:45:15, .day) -> 2024/01/31, 23:59:59
    /// (2024/01/12, 9:45:15, .month) -> 2024/12/31, 23:59:59
    public func end(of date: Date, adjustGranurarity lastComp: Calendar.Component) -> Date? {
        let comps = self.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let keepComps = lastComp.upperUnits
        guard !keepComps.isEmpty else { return nil }

        let newComps = DateComponents(year: keepComps.contains(.year) ? comps.year : comps.lastValue(for: .year, in: self),
                                      month: keepComps.contains(.month) ? comps.month : comps.lastValue(for: .month, in: self),
                                      day: keepComps.contains(.day) ? comps.day : comps.lastValue(for: .day, in: self),
                                      hour: keepComps.contains(.hour) ? comps.hour : comps.lastValue(for: .hour, in: self),
                                      minute: keepComps.contains(.minute) ? comps.minute : comps.lastValue(for: .minute, in: self),
                                      second: keepComps.contains(.second) ? comps.second : comps.lastValue(for: .second, in: self))
        return self.date(from: newComps)
    }
    
    // weekday comes from DateComponent i.e. 1:Sunday, 2:Monday, ... 7: Saturday
    public func endOf(weekday: Int, from date: Date) -> Date? {
        var calcDate: Date? = nil
        Calendar.current.enumerateDates(startingAfter: date, matching: .init(hour: 23, minute: 59, second: 59, weekday: weekday), matchingPolicy: .nextTime,
                                        direction: .forward,
                                        using: { (date, bool, stop) in
            calcDate = date
            stop = true
        })
        return calcDate
    }
}
