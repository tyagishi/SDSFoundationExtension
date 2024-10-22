//
//  Date_Arithmetric_Tests.swift
//
//  Created by : Tomoaki Yagishita on 2024/10/22
//  © 2024  SmallDeskSoftware
//

import XCTest

final class Date_Arithmetric_Tests: XCTestCase {

    func test_plus() async throws {
        var refCal = Calendar.current
        refCal.timeZone = try XCTUnwrap(TimeZone(identifier: "JST"))
        
        let from = refCal.date(from: DateComponents(year: 2024, month: 1, day: 12, hour: 9, minute: 45, second: 15))!
        XCTAssertNotNil(from)
        
        let minAdvanced = from.advanced(Duration.minutes(10))
        XCTAssertEqual(minAdvanced, refCal.date(from: DateComponents(year: 2024, month: 1, day: 12, hour: 9, minute: 55, second: 15))!)

        let hourAdvanced = from.advanced(Duration.hours(10))
        XCTAssertEqual(hourAdvanced, refCal.date(from: DateComponents(year: 2024, month: 1, day: 12, hour: 19, minute: 45, second: 15))!)

        let dayAdvanced = from.advanced(Duration.days(10))
        XCTAssertEqual(dayAdvanced, refCal.date(from: DateComponents(year: 2024, month: 1, day: 22, hour: 9, minute: 45, second: 15))!)
    }
}
