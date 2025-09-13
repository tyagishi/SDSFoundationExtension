//
//  DurationStyleDayHourMinute.swift
//
//  Created by : Tomoaki Yagishita on 2023/06/27
//  © 2023  SmallDeskSoftware
//

import Foundation

@available(macOS 13.0, iOS 16.0, tvOS 16.0, watchOS 9.0, *)
extension Duration {
    public struct FormatStyle: Foundation.FormatStyle {
        public typealias FormatInput = Duration
        public typealias FormatOutput = String
        static let minute: Int64 = 60
        static let hour: Int64 = 60 * 60
        static let day: Int64 = hour * 24
        
        public enum DurationUnit: String, RawRepresentable, Codable {
            case days, hours, minutes, seconds
        }
        public enum DurationUnitStyle: String, RawRepresentable, Codable {
            case noCare
            case omitDaysIfPossible
            case omitHoursAboveIfPossible
            case omitMinutesAboveIfPossible
            case omitSeconds
            
            var omitDays: Bool {
                switch self {
                case .omitDaysIfPossible, .omitHoursAboveIfPossible, .omitMinutesAboveIfPossible: return true
                default: return false
                }
            }
            var omitHours: Bool {
                switch self {
                case .omitHoursAboveIfPossible, .omitMinutesAboveIfPossible: return true
                default: return false
                }
            }
            var omitMinutes: Bool {
                switch self {
                case .omitMinutesAboveIfPossible: return true
                default: return false
                }
            }
        }
        let unitStyle: DurationUnitStyle
        
        init(unitStyle: DurationUnitStyle = .noCare) {
            self.unitStyle = unitStyle
        }

        public func format(_ value: FormatInput) -> FormatOutput {
            let nums = divideNums(value.components.seconds)
            
            var baseString: String = ""
            if !omit(nums, .hours, unitStyle) {
                baseString += String(format: "%02d", Int(nums.hours))
            }
            if !omit(nums, .minutes, unitStyle) {
                if !baseString.isEmpty { baseString += ":" }
                baseString += String(format: "%02d", Int(nums.minutes))
            }
            if !omit(nums, .seconds, unitStyle) {
                if !baseString.isEmpty { baseString += ":" }
                baseString += String(format: "%02d", Int(nums.seconds))
            }

            if !omit(nums, .days, unitStyle) {
                baseString = String(format: "%d", Int(nums.days)) + "days " + baseString
            }
            return baseString
        }
        
        func divideNums(_ sec: Int64) -> (days: Int64, hours: Int64, minutes: Int64, seconds: Int64) {
            let days = Int64(sec / Self.day)
            let hours = Int64((sec - days * Self.day) / Self.hour)
            let minutes = Int64((sec - days * Self.day - hours * Self.hour) / Self.minute)
            let seconds = Int64((sec - days * Self.day - hours * Self.hour - minutes * Self.minute))
            return (days, hours, minutes, seconds)
        }
        
        public func omit(_ nums: (days: Int64, hours: Int64, minutes: Int64, seconds: Int64),_ unit: DurationUnit,_ style: DurationUnitStyle) -> Bool {
            if style == .noCare { return false }
            switch unit {
            case .days:  return (style.omitDays == true) && (nums.days == 0)
            case .hours: return (style.omitHours == true) && (omit(nums, .days, style) == true) && (nums.hours == 0)
            case .minutes:
                return (style.omitMinutes == true) && (omit(nums, .hours, style) == true) && (nums.minutes == 0)
            case .seconds:
                return (style == .omitSeconds)
            }
        }
    }
}

@available(macOS 13.0, iOS 16.0, tvOS 16.0, watchOS 9.0, *)
@available(*, deprecated, renamed: "Duration.FormatStyle", message: "use Duration.FormatStyle instead")
public struct DurationStyleDayHourMinute: FormatStyle {
    public typealias FormatInput = Duration
    public typealias FormatOutput = String
    static let minute: Int64 = 60
    static let hour: Int64 = 60 * 60
    static let day: Int64 = hour * 24

    public func format(_ value: FormatInput) -> FormatOutput {
        let sec = value.components.seconds
        let days = Int64(sec / Self.day)
        let hours = Int64((sec - days * Self.day) / Self.hour)
        let minutes = Int64((sec - days * Self.day - hours * Self.hour) / Self.minute)
        let seconds = Int64((sec - days * Self.day - hours * Self.hour - minutes * Self.minute))
        let baseString = String(format: "%02d", Int(hours)) + ":" + String(format: "%02d", Int(minutes)) + ":" + String(format: "%02d", Int(seconds))
        if days == 0 {
            return baseString
        }
        return String(format: "%d", Int(days)) + "days " + baseString
    }
}

@available(macOS 13.0, iOS 16.0, tvOS 16.0, watchOS 9.0, *)
@available(*, deprecated, renamed: "Duration.FormatStyle", message: "use Duration.FormatStyle instead")
extension FormatStyle where Self == DurationStyleDayHourMinute {
    public static var dayHourMinute: DurationStyleDayHourMinute { .init() }
}

@available(macOS 13.0, iOS 16.0, tvOS 16.0, watchOS 9.0, *)
extension FormatStyle where Self == Duration.FormatStyle {
    public static var dayHourMinute: Duration.FormatStyle { .init() }
}
