//
//  Calendar_StartEndDate_Tests.swift
//
//  Created by : Tomoaki Yagishita on 2024/08/11
//  © 2024  SmallDeskSoftware
//

import XCTest
import Foundation
@testable import SDSFoundationExtension

final class Calendar_StartEndDate_Tests: XCTestCase {
    func test_start() async throws {
        var refCal = Calendar.current
        refCal.timeZone = try XCTUnwrap(TimeZone(identifier: "JST"))
        
        let from = refCal.date(from: DateComponents(year: 2024, month: 3, day: 4, hour: 13, minute: 14, second: 23))!
        XCTAssertNotNil(from)

        let secondStart = refCal.start(of: from, adjustGranurarity: .second)
        XCTAssertEqual(secondStart, refCal.date(from: DateComponents(year: 2024, month: 3, day: 4, hour: 13, minute: 14, second: 0))!)

        let minStart = refCal.start(of: from, adjustGranurarity: .minute)
        XCTAssertEqual(minStart, refCal.date(from: DateComponents(year: 2024, month: 3, day: 4, hour: 13, minute: 0, second: 0))!)

        let hStart = refCal.start(of: from, adjustGranurarity: .hour)
        XCTAssertEqual(hStart, refCal.date(from: DateComponents(year: 2024, month: 3, day: 4, hour: 0, minute: 0, second: 0))!)

        let dStart = refCal.start(of: from, adjustGranurarity: .day)
        XCTAssertEqual(dStart, refCal.date(from: DateComponents(year: 2024, month: 3, day: 1, hour: 0, minute: 0, second: 0))!)

        let mStart = refCal.start(of: from, adjustGranurarity: .month)
        XCTAssertEqual(mStart, refCal.date(from: DateComponents(year: 2024, month: 1, day: 1, hour: 0, minute: 0, second: 0))!)

        // note: special treatment is needed for weekday handling
        let wSStart = refCal.startOf(weekday: 1, from: from) // 2024.Mar.4th is monday, Mar.3rd is sunday
        XCTAssertEqual(wSStart, refCal.date(from: DateComponents(year: 2024, month: 3, day: 3, hour: 0, minute: 0, second: 0))!)
        //let wMStart = refCal.start(of: from, matching: .init(hour: 0, minute: 0, second: 0, weekday: 2)) // 2024.Mar.4th is monday
        let wMStart = refCal.startOf(weekday: 2, from: from)  // 2024.Mar.4th is monday
        XCTAssertEqual(wMStart, refCal.date(from: DateComponents(year: 2024, month: 3, day: 4, hour: 0, minute: 0, second: 0))!)
    }
    
    func test_starts() async throws {
        var refCal = Calendar.current
        refCal.timeZone = try XCTUnwrap(TimeZone(identifier: "JST"))
        
        let from = refCal.date(from: DateComponents(year: 2024, month: 3, day: 4, hour: 13, minute: 14, second: 23))!
        XCTAssertNotNil(from)

        // note: special treatment is needed for weekday handling
        let wSStarts = refCal.startsOf(weekday: 1, from: from, count: 2) // 2024.Mar.4th is monday, Mar.3rd is sunday
        XCTAssertEqual(wSStarts.count, 2)
        XCTAssertEqual(wSStarts[0], refCal.date(from: DateComponents(year: 2024, month: 3, day: 3, hour: 0, minute: 0, second: 0))!)
        XCTAssertEqual(wSStarts[1], refCal.date(from: DateComponents(year: 2024, month: 2, day:25, hour: 0, minute: 0, second: 0))!)
        //let wMStart = refCal.start(of: from, matching: .init(hour: 0, minute: 0, second: 0, weekday: 2)) // 2024.Mar.4th is monday
        let wMStarts = refCal.startsOf(weekday: 2, from: from, count: 2)  // 2024.Mar.4th is monday
        XCTAssertEqual(wMStarts[0], refCal.date(from: DateComponents(year: 2024, month: 3, day: 4, hour: 0, minute: 0, second: 0))!)
        XCTAssertEqual(wMStarts[1], refCal.date(from: DateComponents(year: 2024, month: 2, day:26, hour: 0, minute: 0, second: 0))!)
    }
    
    func test_end() async throws {
        var refCal = Calendar.current
        refCal.timeZone = try XCTUnwrap(TimeZone(identifier: "JST"))
        
        let from = refCal.date(from: DateComponents(year: 2024, month: 1, day: 12, hour: 9, minute: 45, second: 15))!
        XCTAssertNotNil(from)

        // end(of: 2024/01/12, 9:45:15, of: .second) -> 2024/01/12, 9:45:59
        let secEnd = refCal.end(of: from, adjustGranurarity: .second)
        XCTAssertEqual(secEnd, refCal.date(from: DateComponents(year: 2024, month: 1, day: 12, hour: 9, minute: 45, second: 59))!)

        // end(of: 2024/01/12, 9:45:15, of: .second) -> 2024/01/12, 9:45:59
        let minEnd = refCal.end(of: from, adjustGranurarity: .minute)
        XCTAssertEqual(minEnd, refCal.date(from: DateComponents(year: 2024, month: 1, day: 12, hour: 9, minute: 59, second: 59))!)

        // end(of: 2024/01/12, 9:45:15, of: .hour) -> 2024/01/12, 9:59:59
        let hEnd = refCal.end(of: from, adjustGranurarity: .hour)
        XCTAssertEqual(hEnd, refCal.date(from: DateComponents(year: 2024, month: 1, day: 12, hour: 23, minute: 59, second: 59))!)

        // end(of: 2024/01/12, 9:45:15, of: .day) -> 2024/01/12, 23:59:59
        let dEnd = refCal.end(of: from, adjustGranurarity: .day)
        XCTAssertEqual(dEnd, refCal.date(from: DateComponents(year: 2024, month: 1, day: 31, hour: 23, minute: 59, second: 59))!)

        // end(of: 2024/01/12, 9:45:15, of: .month) -> 2024/01/31, 23:59:59
        let mEnd = refCal.end(of: from, adjustGranurarity: .month)
        XCTAssertEqual(mEnd, refCal.date(from: DateComponents(year: 2024, month: 12, day: 31, hour: 23, minute: 59, second: 59))!)

        // note: special treatment is needed for weekday handling
        let wSEnd = refCal.endOf(weekday: 1, from: from) // 2024.Jan.12th is friday, Jan.14th is sunday
        XCTAssertEqual(wSEnd, refCal.date(from: DateComponents(year: 2024, month: 1, day: 14, hour: 23, minute: 59, second: 59))!)
        let wMEnd = refCal.endOf(weekday: 2, from: from) // 2024.Jan.12th is friday, Jan.15th is Monday
        XCTAssertEqual(wMEnd, refCal.date(from: DateComponents(year: 2024, month: 1, day: 15, hour: 23, minute: 59, second: 59))!)
        let wFEnd = refCal.endOf(weekday: 6, from: from) // 2024.Jan.12th is friday
        XCTAssertEqual(wFEnd, refCal.date(from: DateComponents(year: 2024, month: 1, day: 12, hour: 23, minute: 59, second: 59))!)
    }
    
    func test_ends() async throws {
        var refCal = Calendar.current
        refCal.timeZone = try XCTUnwrap(TimeZone(identifier: "JST"))
        
        let from = refCal.date(from: DateComponents(year: 2024, month: 1, day: 12, hour: 9, minute: 45, second: 15))!
        XCTAssertNotNil(from)

        // note: special treatment is needed for weekday handling
        let wSEnds = refCal.endsOf(weekday: 1, from: from, count: 2) // 2024.Jan.12th is friday, Jan.14th is sunday
        XCTAssertEqual(wSEnds[0], refCal.date(from: DateComponents(year: 2024, month: 1, day: 14, hour: 23, minute: 59, second: 59))!)
        XCTAssertEqual(wSEnds[1], refCal.date(from: DateComponents(year: 2024, month: 1, day: 21, hour: 23, minute: 59, second: 59))!)
        let wMEnds = refCal.endsOf(weekday: 2, from: from, count: 2) // 2024.Jan.12th is friday, Jan.15th is Monday
        XCTAssertEqual(wMEnds[0], refCal.date(from: DateComponents(year: 2024, month: 1, day: 15, hour: 23, minute: 59, second: 59))!)
        XCTAssertEqual(wMEnds[1], refCal.date(from: DateComponents(year: 2024, month: 1, day: 22, hour: 23, minute: 59, second: 59))!)
        let wFEnds = refCal.endsOf(weekday: 6, from: from, count: 2) // 2024.Jan.12th is friday
        XCTAssertEqual(wFEnds[0], refCal.date(from: DateComponents(year: 2024, month: 1, day: 12, hour: 23, minute: 59, second: 59))!)
        XCTAssertEqual(wFEnds[1], refCal.date(from: DateComponents(year: 2024, month: 1, day: 19, hour: 23, minute: 59, second: 59))!)

    }
}
