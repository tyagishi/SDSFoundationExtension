//
//  DurationStyleDayHourMinute_Tests.swift
//
//  Created by : Tomoaki Yagishita on 2023/06/27
//  © 2023  SmallDeskSoftware
//

import XCTest
@testable import SDSFoundationExtension

final class DurationStyleDayHourMinute_Tests: XCTestCase {
    @available(*, deprecated, renamed: "Duration.FormatStyle", message: "use Duration.FormatStyle instead")
    func test_Existing() throws {
        let duration = Duration(secondsComponent: Int64(60.0*60.0*24.0*4.5), attosecondsComponent: 0)

        XCTAssertEqual(duration.formatted(.time(pattern: .hourMinuteSecond)), "108:00:00")
        XCTAssertEqual(duration.formatted(DurationStyleDayHourMinute()), "4days 12:00:00")
        XCTAssertEqual(duration.formatted(DurationStyleDayHourMinute.dayHourMinute), "4days 12:00:00")
    }

    func test_NewDurationFormatStyle() throws {
        let duration = Duration(secondsComponent: Int64(60.0*60.0*24.0*4.5), attosecondsComponent: 0)

        //XCTAssertEqual(duration.formatted(.time(pattern: .hourMinuteSecond)), "108:00:00")
        XCTAssertEqual(duration.formatted(Duration.FormatStyle.init(unitStyle: .noCare)), "4days 12:00:00")
//        XCTAssertEqual(duration.formatted(.dayHourMinute), "4days 12:00:00")
    }

    func test_NewDurationFormatStyle_OmitDays() throws {
        let duration = Duration(secondsComponent: Int64(60.0*60.0*18.24), attosecondsComponent: 0)

        XCTAssertEqual(duration.formatted(Duration.FormatStyle.init(unitStyle: .noCare)), "0days 18:14:24")
        XCTAssertEqual(duration.formatted(Duration.FormatStyle.init(unitStyle: .omitDaysIfPossible)), "18:14:24")
    }

    func test_NewDurationFormatStyle_OmitDaysHours() throws {
        let duration = Duration(secondsComponent: Int64(60.0*18.24), attosecondsComponent: 0)

        XCTAssertEqual(duration.formatted(Duration.FormatStyle.init(unitStyle: .noCare)), "0days 00:18:14")
        XCTAssertEqual(duration.formatted(Duration.FormatStyle.init(unitStyle: .omitHoursAboveIfPossible)), "18:14")
    }

}
