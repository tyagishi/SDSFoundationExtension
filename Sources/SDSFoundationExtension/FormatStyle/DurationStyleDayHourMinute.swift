//
//  DurationStyleDayHourMinute.swift
//
//  Created by : Tomoaki Yagishita on 2023/06/27
//  © 2023  SmallDeskSoftware
//

import Foundation

@available(macOS 13.0, iOS 16.0, tvOS 16.0, watchOS 9.0, *)
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
extension FormatStyle where Self == DurationStyleDayHourMinute {
    public static var dayHourMinute: DurationStyleDayHourMinute { .init() }
}
