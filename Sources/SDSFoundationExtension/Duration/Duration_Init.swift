//
//  Duration_Init.swift
//
//  Created by : Tomoaki Yagishita on 2024/10/22
//  © 2024  SmallDeskSoftware
//

import Foundation

@available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
extension Duration {
    @available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
    @inlinable public static func minutes(_ minutes: Double) -> Duration {
        Duration(secondsComponent: Int64(minutes * 60), attosecondsComponent: 0)
    }
    
    @available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
    @inlinable public static func hours(_ hours: Double) -> Duration {
        Duration(secondsComponent: Int64(hours * 60 * 60), attosecondsComponent: 0)
    }
    
    @available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
    @inlinable public static func days(_ days: Double) -> Duration {
        Duration(secondsComponent: Int64(days * 24 * 60 * 60), attosecondsComponent: 0)
    }
    @available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
    @inlinable public static func weeks(_ weeks: Double) -> Duration {
        Duration(secondsComponent: Int64(weeks * 7 * 24 * 60 * 60), attosecondsComponent: 0)
    }
}
