//
//  DimensionPair_Tests.swift
//  SDSFoundationExtension
//
//  Created by Tomoaki Yagishita on 2025/09/11.
//

import Foundation
import XCTest
@testable import SDSFoundationExtension

@MainActor
final class MeasurementPair_Tests: XCTestCase {
    let tableSpoonML = 0.0147868 * 1000
    let serveSugarDensity = 0.6

    func test_MeasurementPair_basicCalc() async throws {
        // ServeSugar 5 tbsp -> 5 * 14.7868 * 0.6 (gram)
        let sugar5btsp = MeasurementPair<UnitMass, UnitVolume>(5, altUnit: .tablespoons, toBaseConverter: UnitConverterLinear(coefficient: serveSugarDensity))
        let sugar5btsp_altMeasurement = sugar5btsp.altMeasurement
        XCTAssertEqual(sugar5btsp_altMeasurement.value, 5)
        XCTAssertEqual(sugar5btsp_altMeasurement.unit, UnitVolume.tablespoons)
        let sugar5btsp_baseMeasurement = sugar5btsp.baseMeasurement
        XCTAssertEqual(sugar5btsp_baseMeasurement.value, 5 * 14.7868 * serveSugarDensity / 1000)
        XCTAssertEqual(sugar5btsp_baseMeasurement.unit, UnitMass.kilograms)
        
        XCTAssertEqual(sugar5btsp.baseMeasurement.converted(to: .grams).value, tableSpoonML * 0.6 * 5, accuracy: 0.1)
        
        // serveSugar 10g -> 10/0.6 tbsp
        let sugar10g = MeasurementPair<UnitMass, UnitVolume>(10, baseUnit: .grams, toBaseConverter: UnitConverterLinear(coefficient: serveSugarDensity))
        let sugar10g_baseMeasurement = sugar10g.baseMeasurement
        XCTAssertEqual(sugar10g_baseMeasurement.value, 10)
        XCTAssertEqual(sugar10g_baseMeasurement.unit, UnitMass.grams)
        let sugar10g_altMeasurement = sugar10g.altMeasurement
        XCTAssertEqual(sugar10g_altMeasurement.value, 10 / serveSugarDensity / 1000) // i.e. 0.01666667 liter
        XCTAssertEqual(sugar10g_altMeasurement.unit, UnitVolume.baseUnit())
        // 10/0.6/1000/0.0147868 -> 1.12713141 tbsp
        XCTAssertEqual(sugar10g.altMeasurement.converted(to: .tablespoons).value, 1.12713141, accuracy: 0.1)
    }



}
