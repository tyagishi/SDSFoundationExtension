//
//  FileMeasurementPair.swift
//  SDSFoundationExtension
//
//  Created by Tomoaki Yagishita on 2025/09/11.
//

import Foundation

/// Measurement Pair
/// in case conversion rule is known, we can use 2 measurement together with convenient conversion
///
/// note:
///   basically measurement is sotred with given measurement/unit.
///   if requested, converted another side measurement will be provided.
///   need to pass UnitConverter to define the relation between baseMeasurement and altMeasurement
///
///   (if requested) another side measurement is given with its base unit. you can convert to your unit with Measurement functionality
///
@available(iOS 10, macOS 10.12, *)
public struct MeasurementPair<S,T> where S: Dimension, T: Dimension {
    let _baseMeasurement: Measurement<S>?     // swiftlint:disable:this identifier_name
    let _altMeasurement: Measurement<T>?      // swiftlint:disable:this identifier_name
    let toBaseConverter: UnitConverter
    
    public init(_ value: Double, baseUnit: S, toBaseConverter: UnitConverter) {
        self._baseMeasurement = Measurement(value: value, unit: baseUnit)
        self._altMeasurement = nil
        self.toBaseConverter = toBaseConverter
    }
    public init(_ value: Double, altUnit: T, toBaseConverter: UnitConverter) {
        self._baseMeasurement = nil
        self._altMeasurement = Measurement(value: value, unit: altUnit)
        self.toBaseConverter = toBaseConverter
    }
    
    public var baseMeasurement: Measurement<S> {
        if let baseMeasurement = _baseMeasurement { return baseMeasurement }
        guard let measurement = _altMeasurement else { fatalError("double nil should not be there")}
        let base = measurement.unit.converter.baseUnitValue(fromValue: measurement.value)
        let convertedValue = toBaseConverter.baseUnitValue(fromValue: base)
        return Measurement(value: convertedValue, unit: S.baseUnit())
    }
    public var altMeasurement: Measurement<T> {
        if let altmeasurement = _altMeasurement { return altmeasurement }
        guard let baseMeasurement = _baseMeasurement else { fatalError("double nil should not be there")}
        let baseUnitValue = baseMeasurement.unit.converter.baseUnitValue(fromValue: baseMeasurement.value)
        let altUnitValue = toBaseConverter.value(fromBaseUnitValue: baseUnitValue)
        return Measurement(value: altUnitValue, unit: T.baseUnit())
    }
}
