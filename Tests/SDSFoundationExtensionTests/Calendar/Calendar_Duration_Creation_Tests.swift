//
//  Calendar_Duration_Creation_Tests.swift
//  SDSFoundationExtension
//
//  Created by Tomoaki Yagishita on 2026/04/25.
//

import XCTest
@testable import SDSFoundationExtension

final class Calendar_Duration_Creation_Tests: XCTestCase {

    func test_Calendar_yearsDuration_calcBeforeLeapDay() async throws {
        let sut = Calendar.current

        // note: 2024 is leapYear
        let leapYear = sut.date(2024, 1, 1)
        var duration = sut.duration(years: 1, from: leapYear)
        XCTAssertEqual(duration, Duration.days(366))
        duration = sut.duration(years:2, from: leapYear)
        XCTAssertEqual(duration, Duration.days(366+365))
    }

    func test_Calendar_yearsDuration_calcAfterLeapDay() async throws {
        let sut = Calendar.current

        // note: 2024 is leapYear
        let testYear = sut.date(2024, 4, 1)
        let duration = sut.duration(years:1, from: testYear)
        XCTAssertEqual(duration, Duration.days(365))
    }
    
    func test_Calendar_monthsDuration_calcBeforeLeapDay() async throws {
        let sut = Calendar.current

        // note: 2024.2 is leapMonth
        let leapYear = sut.date(2024, 2, 1)
        let duration = sut.duration(months: 1, from: leapYear)
        XCTAssertEqual(duration, Duration.days(29))
    }

    func test_Calendar_monthsDuration_calcAfterLeapDay() async throws {
        let sut = Calendar.current

        // note: 2024.2 is leapMonth
        let testYear = sut.date(2024, 1, 28)
        let duration = sut.duration(months: 1, from: testYear)
        XCTAssertEqual(duration, Duration.days(31))
    }
}
