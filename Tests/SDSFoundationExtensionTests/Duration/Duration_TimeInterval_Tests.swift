//
//  Duration_TimeInterval_Tests.swift
//  SDSFoundationExtension
//
//  Created by Tomoaki Yagishita on 2026/04/17.
//

import XCTest
import Foundation
@testable import SDSFoundationExtension

final class Duration_TimeInterval_Tests: XCTestCase {
    func test_duration_toTimeInterval() async throws {
        let fiveSec = Duration.seconds(5)

        let fiveSecInTimeInterval = fiveSec.timeInterval
        XCTAssertEqual(fiveSecInTimeInterval, 5.0, accuracy: 0.001)
    }

    func test_duration_toTimeIntervalBelowZero() async throws {
        let dotFiveSec = Duration.seconds(0.5)

        let dotFiveSecInTimeInterval = dotFiveSec.timeInterval
        XCTAssertEqual(dotFiveSecInTimeInterval, 0.5, accuracy: 0.001)
    }


    func test_duration_fromTimeInterval() async throws {
        let fiveSecInTimeInterval: TimeInterval = 5.0
        let fiveSec = Duration(seconds: fiveSecInTimeInterval)

        let (seconds, attoSeconds) = fiveSec.components

        XCTAssertEqual(seconds, 5)
        XCTAssertEqual(attoSeconds, 0)
    }

    func test_duration_fromTimeInterval_below1Sec() async throws {
        let below1SecTI: TimeInterval = 0.1
        let below1Sec = Duration(seconds: below1SecTI)

        let (seconds, attoSeconds) = below1Sec.components
        let e17 = Int64(1.0e17)
        XCTAssertEqual(seconds, 0)
        XCTAssertEqual(attoSeconds, e17)
    }
}
