//
//  DurationStyleDayHourMinute_Tests.swift
//
//  Created by : Tomoaki Yagishita on 2023/06/27
//  © 2023  SmallDeskSoftware
//

import XCTest
@testable import SDSFoundationExtension

final class DurationStyleDayHourMinute_Tests: XCTestCase {
    func test_Existing() throws {
        let duration = Duration(secondsComponent: Int64(60.0*60.0*24.0*4.5), attosecondsComponent: 0)

        XCTAssertEqual(duration.formatted(.time(pattern: .hourMinuteSecond)), "108:00:00")
        XCTAssertEqual(duration.formatted(DurationStyleDayHourMinute()), "4days 12:00:00")
        XCTAssertEqual(duration.formatted(.dayHourMinute), "4days 12:00:00")
    }

}
