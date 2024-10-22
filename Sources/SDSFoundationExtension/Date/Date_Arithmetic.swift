//
//  File.swift
//
//  Created by : Tomoaki Yagishita on 2024/10/22
//  © 2024  SmallDeskSoftware
//

import Foundation

extension Date {
    @available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
    public func advanced(_ duration: Duration) -> Date {
        self.advanced(by: duration.timeInterval)
    }
}
