//
//  RangeBinaryIntegerFormatStyle_Tests.swift
//  SDSFoundationExtension
//
//  Created by Tomoaki Yagishita on 2025/09/18.
//

import XCTest
import Foundation
@testable import SDSFoundationExtension

final class RangeBinaryIntegerFormatStyle_Tests: XCTestCase {

    func test_RangeBinaryIntegerFormatStyle_open() throws {
        let values: Range<Int> = 2..<5

        let sut = Range<Int>.FormatStyle()
        XCTAssertEqual(sut.format(values), "2-5")

        XCTAssertEqual(values.formatted(Range.FormatStyle()), "2-5")
        XCTAssertEqual(values.formatted(Range.FormatStyle(type: .math)), "[2,5)")
        XCTAssertEqual(values.formatted(Range.FormatStyle(type: .swift)), "2..<5")
    }
    
    func test_RangeBinaryIntegerFormatStyle_close() throws {
        let values: Range<Int> = 2..<5

        let sut = Range<Int>.FormatStyle(showWithCloseSection: true)
        XCTAssertEqual(sut.format(values), "2-4")

        XCTAssertEqual(values.formatted(Range.FormatStyle(showWithCloseSection: true)), "2-4")
        XCTAssertEqual(values.formatted(Range.FormatStyle(showWithCloseSection: true, type: .math)), "[2,4]")
        XCTAssertEqual(values.formatted(Range.FormatStyle(showWithCloseSection: true, type: .swift)), "2...4")
    }
}
