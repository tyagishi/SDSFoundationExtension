//
//  Calendar_DateCreation_Tests.swift
//  SDSFoundationExtension
//
//  Created by Tomoaki Yagishita on 2024/12/02.
//

import XCTest
@testable import SDSFoundationExtension

final class Calendar_DateCreation_Tests: XCTestCase {

    func test_Calendar_date() async throws {
        let sut = Calendar.current
        
        let d2024Jan1_000000 = Calendar.current.date(from: DateComponents(year: 2024, month: 1))!
        let d2024Jan13_134512 = Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 13, hour: 13, minute: 45, second: 12))!
        
        XCTAssertEqual(sut.date(2024, 1), d2024Jan1_000000)
        XCTAssertEqual(sut.date(2024, 1, 13, hour: 13, minute: 45, second: 12), d2024Jan13_134512)
    }
    func test_Calendar_yearStartEnd() async throws {
        let sut = Calendar.current

        let (start,end) = sut.yearStartEnd(of: 2024)
        let d2024Jan1_000000 = Calendar.current.date(from: DateComponents(year: 2024, month: 1))!
        let d2024Dec31_235959 = Calendar.current.date(from: DateComponents(year: 2024, month: 12, day: 31, hour: 23, minute: 59, second: 59))!
        XCTAssertEqual(start, d2024Jan1_000000)
        XCTAssertEqual(end, d2024Dec31_235959)
    }
}
