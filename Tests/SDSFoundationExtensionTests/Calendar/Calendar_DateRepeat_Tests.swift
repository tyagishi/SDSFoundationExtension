//
//  Calendar_DateRepeat_Tests.swift
//  SDSFoundationExtension
//
//  Created by Tomoaki Yagishita on 2025/04/14.
//

import Foundation
import XCTest
@testable import SDSFoundationExtension

final class Calendar_DateRepeat_Tests: XCTestCase {

    func test_RepeatDate_Monthly() async throws {
        let sut = Calendar.current
        let start = sut.date(2023, 1, 1, hour: 0, minute: 0)
        let end = sut.date(2023,12,31, hour: 23, minute: 59)

        let expect = [sut.date(2023, 1, 1, hour: 0, minute: 0),
                      sut.date(2023, 2, 1, hour: 0, minute: 0),
                      sut.date(2023, 3, 1, hour: 0, minute: 0),
                      sut.date(2023, 4, 1, hour: 0, minute: 0),
                      sut.date(2023, 5, 1, hour: 0, minute: 0),
                      sut.date(2023, 6, 1, hour: 0, minute: 0),
                      sut.date(2023, 7, 1, hour: 0, minute: 0),
                      sut.date(2023, 8, 1, hour: 0, minute: 0),
                      sut.date(2023, 9, 1, hour: 0, minute: 0),
                      sut.date(2023,10, 1, hour: 0, minute: 0),
                      sut.date(2023,11, 1, hour: 0, minute: 0),
                      sut.date(2023,12, 1, hour: 0, minute: 0),
        ]

        let dates = sut.repeatDates(from: start, to: end, frequency: .monthly, adjustment: .noAdjustment)
        XCTAssertEqual(dates, expect)
    }

    func test_RepeatDate_Yearly() async throws {
        let sut = Calendar.current
        let start = sut.date(2023, 1, 1, hour: 0, minute: 0)
        let end = sut.date(2026,12,31, hour: 23, minute: 59)

        let expect = [sut.date(2023, 1, 1, hour: 0, minute: 0),
                      sut.date(2024, 1, 1, hour: 0, minute: 0),
                      sut.date(2025, 1, 1, hour: 0, minute: 0),
                      sut.date(2026, 1, 1, hour: 0, minute: 0),
        ]
        
        let dates = sut.repeatDates(from: start, to: end, frequency: .yearly, adjustment: .noAdjustment)
        XCTAssertEqual(dates, expect)
    }

    func test_RepeatDate_twiceAYear_startOfMonth() async throws {
        let sut = Calendar.current
        let start = sut.date(2023, 1, 1, hour: 0, minute: 0)
        let end = sut.date(2025,12,31, hour: 23, minute:59)
        
        let expect = [sut.date(2023, 1, 1, hour: 0, minute: 0),
                      sut.date(2023, 7, 1, hour: 0, minute: 0),
                      sut.date(2024, 1, 1, hour: 0, minute: 0),
                      sut.date(2024, 7, 1, hour: 0, minute: 0),
                      sut.date(2025, 1, 1, hour: 0, minute: 0),
                      sut.date(2025, 7, 1, hour: 0, minute: 0),
        ]
        
        let dates = sut.repeatDates(from: start, to: end, frequency: .twiceAYear, adjustment: .noAdjustment)
        XCTAssertEqual(dates, expect)
    }

    func test_RepeatDate_twiceAYear_endOfMonth_none() async throws {
        let sut = Calendar.current
        let start = sut.date(2023, 1,31, hour: 0, minute: 0)
        let end = sut.date(2025,12,31, hour: 23, minute: 59)
        
        let expect = [sut.date(2023, 1,31, hour: 0, minute: 0),
                      sut.date(2023, 7,31, hour: 0, minute: 0),
                      sut.date(2024, 1,31, hour: 0, minute: 0),
                      sut.date(2024, 7,31, hour: 0, minute: 0),
                      sut.date(2025, 1,31, hour: 0, minute: 0),
                      sut.date(2025, 7,31, hour: 0, minute: 0),
        ]
        
        let dates = sut.repeatDates(from: start, to: end, frequency: .twiceAYear, adjustment: .noAdjustment)
        XCTAssertEqual(dates, expect)
    }

    func test_RepeatDate_twiceAYear_endOfMonth_adjustToEoM() async throws {
        let sut = Calendar.current
        let start = sut.date(2023, 1,15, hour: 0, minute: 0)
        let end = sut.date(2025,12,31, hour: 23, minute: 59)
        
        let expect = [sut.date(2023, 1,31, hour: 0, minute: 0),
                      sut.date(2023, 7,31, hour: 0, minute: 0),
                      sut.date(2024, 1,31, hour: 0, minute: 0),
                      sut.date(2024, 7,31, hour: 0, minute: 0),
                      sut.date(2025, 1,31, hour: 0, minute: 0),
                      sut.date(2025, 7,31, hour: 0, minute: 0),
        ]
        
        let dates = sut.repeatDates(from: start, to: end, frequency: .twiceAYear, adjustment: .endOfMonth)
        XCTAssertEqual(dates, expect)
    }

    func test_RepeatDate_quartely_startOfMonth() async throws {
        let sut = Calendar.current
        let start = sut.date(2023, 1, 1, hour: 0, minute: 0)
        let end = sut.date(2024,12,31, hour: 23, minute: 59)
        
        let expect = [sut.date(2023, 1, 1, hour: 0, minute: 0),
                      sut.date(2023, 4, 1, hour: 0, minute: 0),
                      sut.date(2023, 7, 1, hour: 0, minute: 0),
                      sut.date(2023,10, 1, hour: 0, minute: 0),
                      sut.date(2024, 1, 1, hour: 0, minute: 0),
                      sut.date(2024, 4, 1, hour: 0, minute: 0),
                      sut.date(2024, 7, 1, hour: 0, minute: 0),
                      sut.date(2024,10, 1, hour: 0, minute: 0),
        ]
        
        let dates = sut.repeatDates(from: start, to: end, frequency: .quarterly, adjustment: .noAdjustment)
        XCTAssertEqual(dates, expect)
    }

    func test_RepeatDate_quartely_endOfMonth_none() async throws {
        let sut = Calendar.current
        let start = sut.date(2023, 1,31, hour: 0, minute: 0)
        let end = sut.date(2024,12,31,hour: 23, minute:59)
        
        let expect = [sut.date(2023, 1,31, hour: 0, minute: 0),
                      sut.date(2023, 4,30, hour: 0, minute: 0),
                      sut.date(2023, 7,30, hour: 0, minute: 0),
                      sut.date(2023,10,30, hour: 0, minute: 0),
                      sut.date(2024, 1,30, hour: 0, minute: 0),
                      sut.date(2024, 4,30, hour: 0, minute: 0),
                      sut.date(2024, 7,30, hour: 0, minute: 0),
                      sut.date(2024,10,30, hour: 0, minute: 0),
        ]
        
        let dates = sut.repeatDates(from: start, to: end, frequency: .quarterly, adjustment: .noAdjustment)
        XCTAssertEqual(dates, expect)
    }

    func test_RepeatDate_quarterly_endOfMonth_adjustToEoM() async throws {
        let sut = Calendar.current
        let start = sut.date(2023, 1,15, hour: 0, minute: 0)
        let end = sut.date(2024,12,31, hour: 23, minute: 59)
        
        let expect = [sut.date(2023, 1,31, hour: 0, minute: 0),
                      sut.date(2023, 4,30, hour: 0, minute: 0),
                      sut.date(2023, 7,31, hour: 0, minute: 0),
                      sut.date(2023,10,31, hour: 0, minute: 0),
                      sut.date(2024, 1,31, hour: 0, minute: 0),
                      sut.date(2024, 4,30, hour: 0, minute: 0),
                      sut.date(2024, 7,31, hour: 0, minute: 0),
                      sut.date(2024,10,31, hour: 0, minute: 0),
        ]
        
        let dates = sut.repeatDates(from: start, to: end, frequency: .quarterly, adjustment: .endOfMonth)
        XCTAssertEqual(dates, expect)
    }

    func test_RepeatDate_biMonthly_startOfMonth() async throws {
        let sut = Calendar.current
        let start = sut.date(2023, 1, 1, hour: 0, minute: 0)
        let end = sut.date(2024,6,30, hour: 23, minute: 59)
        
        let expect = [sut.date(2023, 1, 1, hour: 0, minute: 0),
                      sut.date(2023, 3, 1, hour: 0, minute: 0),
                      sut.date(2023, 5, 1, hour: 0, minute: 0),
                      sut.date(2023, 7, 1, hour: 0, minute: 0),
                      sut.date(2023, 9, 1, hour: 0, minute: 0),
                      sut.date(2023,11, 1, hour: 0, minute: 0),
                      sut.date(2024, 1, 1, hour: 0, minute: 0),
                      sut.date(2024, 3, 1, hour: 0, minute: 0),
                      sut.date(2024, 5, 1, hour: 0, minute: 0),
        ]
        
        let dates = sut.repeatDates(from: start, to: end, frequency: .biMonthly, adjustment: .noAdjustment)
        XCTAssertEqual(dates, expect)
    }

    func test_RepeatDate_biMonthly_endOfMonth_none() async throws {
        let sut = Calendar.current
        let start = sut.date(2023, 1, 31, hour: 0, minute: 0)
        let end = sut.date(2024, 6, 30, hour: 23, minute: 59)

        let expect = [sut.date(2023, 1,31, hour: 0, minute: 0),
                      sut.date(2023, 3,31, hour: 0, minute: 0),
                      sut.date(2023, 5,31, hour: 0, minute: 0),
                      sut.date(2023, 7,31, hour: 0, minute: 0),
                      sut.date(2023, 9,30, hour: 0, minute: 0),
                      sut.date(2023,11,30, hour: 0, minute: 0),
                      sut.date(2024, 1,30, hour: 0, minute: 0),
                      sut.date(2024, 3,30, hour: 0, minute: 0),
                      sut.date(2024, 5,30, hour: 0, minute: 0),
        ]
        
        let dates = sut.repeatDates(from: start, to: end, frequency: .biMonthly, adjustment: .noAdjustment)
        XCTAssertEqual(dates, expect)
    }

    func test_RepeatDate_biMonthly_endOfMonth_adjustToEoM() async throws {
        let sut = Calendar.current
        let start = sut.date(2023, 1,15, hour: 0, minute: 0)
        let end = sut.date(2024, 6,30, hour: 23, minute: 59)
        
        let expect = [sut.date(2023, 1,31, hour: 0, minute: 0),
                      sut.date(2023, 3,31, hour: 0, minute: 0),
                      sut.date(2023, 5,31, hour: 0, minute: 0),
                      sut.date(2023, 7,31, hour: 0, minute: 0),
                      sut.date(2023, 9,30, hour: 0, minute: 0),
                      sut.date(2023,11,30, hour: 0, minute: 0),
                      sut.date(2024, 1,31, hour: 0, minute: 0),
                      sut.date(2024, 3,31, hour: 0, minute: 0),
                      sut.date(2024, 5,31, hour: 0, minute: 0),
        ]
        
        let dates = sut.repeatDates(from: start, to: end, frequency: .biMonthly, adjustment: .endOfMonth)
        XCTAssertEqual(dates, expect)
    }

    func test_repeatDates_monthly_nextWorkingDay() async throws {
        let sut = Calendar.current
        let startDate = Calendar.current.date(from: DateComponents(year: 2023, month: 1, day: 5, hour: 10, minute: 0, second: 0))!
        let endDate = Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 5, hour: 9, minute: 0, second: 0))!
        
        
        // note: Feb-5(Sun), Mar-5(Sun), Aug-5(Sat), Nov-5(Sun)
        let repeatDates = sut.repeatDates(from: startDate, to: endDate, frequency: .monthly, adjustment: .nextWorkingDay)
        XCTAssertEqual(repeatDates.count, 12)
        XCTAssertEqual(repeatDates.map({Calendar.current.dateComponents(in: .current, from: $0)}).filter({$0.hour != 10}).count, 0)
        XCTAssertEqual(repeatDates.map({Calendar.current.dateComponents(in: .current, from: $0)}).filter({$0.minute != 0}).count, 0)
        XCTAssertEqual(repeatDates.map({Calendar.current.dateComponents(in: .current, from: $0)}).filter({$0.second != 0}).count, 0)
        let feb = Calendar.current.dateComponents(in: .current, from: repeatDates[1])
        XCTAssertEqual(feb.day, 6)
        let mar = Calendar.current.dateComponents(in: .current, from: repeatDates[2])
        XCTAssertEqual(mar.day, 6)
        let aug = Calendar.current.dateComponents(in: .current, from: repeatDates[7])
        XCTAssertEqual(aug.day, 7)
        let nov = Calendar.current.dateComponents(in: .current, from: repeatDates[10])
        XCTAssertEqual(nov.day, 6)
    }

    func test_repeatDates_monthly_prevWorkingDay() async throws {
        let sut = Calendar.current
        let startDate = Calendar.current.date(from: DateComponents(year: 2023, month: 1, day: 5, hour: 10, minute: 0, second: 0))!
        let endDate = Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 5, hour: 9, minute: 0, second: 0))!
        
        // note: Feb-5(Sun), Mar-5(Sun), Aug-5(Sat), Nov-5(Sun)
        
        let repeatDates = sut.repeatDates(from: startDate, to: endDate, frequency: .monthly, adjustment: .prevWorkingDay)
        XCTAssertEqual(repeatDates.count, 12)
        XCTAssertEqual(repeatDates.map({Calendar.current.dateComponents(in: .current, from: $0)}).filter({$0.hour != 10}).count, 0)
        XCTAssertEqual(repeatDates.map({Calendar.current.dateComponents(in: .current, from: $0)}).filter({$0.minute != 0}).count, 0)
        XCTAssertEqual(repeatDates.map({Calendar.current.dateComponents(in: .current, from: $0)}).filter({$0.second != 0}).count, 0)
        let feb = Calendar.current.dateComponents(in: .current, from: repeatDates[1])
        XCTAssertEqual(feb.day, 3)
        let mar = Calendar.current.dateComponents(in: .current, from: repeatDates[2])
        XCTAssertEqual(mar.day, 3)
        let aug = Calendar.current.dateComponents(in: .current, from: repeatDates[7])
        XCTAssertEqual(aug.day, 4)
        let nov = Calendar.current.dateComponents(in: .current, from: repeatDates[10])
        XCTAssertEqual(nov.day, 3)
    }

    func test_repeatDates_monthly_endOfMonth() async throws {
        let sut = Calendar.current
        let startDate = Calendar.current.date(from: DateComponents(year: 2023, month: 2, day: 26, hour: 10, minute: 0, second: 0))!
        let endDate = Calendar.current.date(from: DateComponents(year: 2024, month: 2, day: 25, hour: 10, minute: 0, second: 0))!
        
        // note: Feb-5(Sun), Mar-5(Sun), Aug-5(Sat), Nov-5(Sun)
        
        let repeatDates = sut.repeatDates(from: startDate, to: endDate, frequency: .monthly, adjustment: .endOfMonth)
        XCTAssertEqual(repeatDates.count, 12)
        XCTAssertEqual(repeatDates.map({Calendar.current.dateComponents(in: .current, from: $0)}).filter({$0.hour != 10}).count, 0)
        XCTAssertEqual(repeatDates.map({Calendar.current.dateComponents(in: .current, from: $0)}).filter({$0.minute != 0}).count, 0)
        XCTAssertEqual(repeatDates.map({Calendar.current.dateComponents(in: .current, from: $0)}).filter({$0.second != 0}).count, 0)
        
        let feb = Calendar.current.dateComponents(in: .current, from: repeatDates[0])
        let mar = Calendar.current.dateComponents(in: .current, from: repeatDates[1])
        let apr = Calendar.current.dateComponents(in: .current, from: repeatDates[2])
        let may = Calendar.current.dateComponents(in: .current, from: repeatDates[3])
        let jun = Calendar.current.dateComponents(in: .current, from: repeatDates[4])
        let jul = Calendar.current.dateComponents(in: .current, from: repeatDates[5])
        let aug = Calendar.current.dateComponents(in: .current, from: repeatDates[6])
        let sep = Calendar.current.dateComponents(in: .current, from: repeatDates[7])
        let oct = Calendar.current.dateComponents(in: .current, from: repeatDates[8])
        let nov = Calendar.current.dateComponents(in: .current, from: repeatDates[9])
        let dec = Calendar.current.dateComponents(in: .current, from: repeatDates[10])
        let jan = Calendar.current.dateComponents(in: .current, from: repeatDates[11])
        XCTAssertEqual(feb.day, 28)
        XCTAssertEqual(mar.day, 31)
        XCTAssertEqual(apr.day, 30)
        XCTAssertEqual(may.day, 31)
        XCTAssertEqual(jun.day, 30)
        XCTAssertEqual(jul.day, 31)
        XCTAssertEqual(aug.day, 31)
        XCTAssertEqual(sep.day, 30)
        XCTAssertEqual(oct.day, 31)
        XCTAssertEqual(nov.day, 30)
        XCTAssertEqual(dec.day, 31)
        XCTAssertEqual(jan.day, 31)
    }
}
