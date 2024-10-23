//
//  Duration_init_Tests.swift
//
//  Created by : Tomoaki Yagishita on 2024/10/22
//  © 2024  SmallDeskSoftware
//

import XCTest

final class Duration_init_Tests: XCTestCase {
    func test_inits() async throws {
        let minute = Duration.minutes(1)
        XCTAssertEqual(minute.components.seconds, 60)
        XCTAssertEqual(minute.components.attoseconds, 0)

        let hours = Duration.hours(2)
        XCTAssertEqual(hours.components.seconds, 60*60*2)
        XCTAssertEqual(hours.components.attoseconds, 0)

        let days = Duration.days(3)
        XCTAssertEqual(days.components.seconds, 24*60*60*3)
        XCTAssertEqual(days.components.attoseconds, 0)

        let weeks = Duration.weeks(3)
        XCTAssertEqual(weeks.components.seconds, 7*24*60*60*3)
        XCTAssertEqual(weeks.components.attoseconds, 0)
    }
}
