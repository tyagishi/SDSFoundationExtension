//
//  Duration_TimeInterval.swift
//
//  Created by : Tomoaki Yagishita on 2024/10/22
//  © 2024  SmallDeskSoftware
//

import Foundation

@available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
extension Duration {
    @available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
    var timeInterval: TimeInterval {
        let (seconds, attSeconds) = self.components
        return Double(seconds) + Double(attSeconds) * 1.0e-18
    }
}
