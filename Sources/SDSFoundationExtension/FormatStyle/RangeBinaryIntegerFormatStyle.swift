//
//  File.swift
//  SDSFoundationExtension
//
//  Created by Tomoaki Yagishita on 2025/09/18.
//

import Foundation

@available(macOS 13.0, iOS 16.0, tvOS 16.0, watchOS 9.0, *)
extension Range where Bound: BinaryInteger {
    public struct FormatStyle: Foundation.FormatStyle {
        public typealias FormatInput = Range<Bound>
        public typealias FormatOutput = String
        
        public enum ExpressionType: String, RawRepresentable, Codable {
            case minus
            case math
            case swift
            
            public var typePrefix: String {
                switch self {
                case .minus:  return ""
                case .math:   return "["
                case .swift:  return ""
                }
            }
            public func typeMiddle(close: Bool = false) -> String {
                switch self {
                case .minus:  return "-"
                case .math:   return ","
                case .swift:
                    if close { return "..."}
                    return "..<"
                }
            }
            public func typePostfix(close: Bool = false) -> String {
                switch self {
                case .minus:  return ""
                case .math:
                    if close { return "]"}
                    return ")"
                case .swift:  return ""
                }
            }
        }
        let type: ExpressionType
        
        let lowerFormatStyle: IntegerFormatStyle<Bound>
        let upperFormatStyle: IntegerFormatStyle<Bound>
        let showWithCloseSection: Bool

        public init(showWithCloseSection: Bool = false,
                    type: ExpressionType = .minus,
                    lowerFormatStyle: IntegerFormatStyle<Bound> = IntegerFormatStyle(),
                    upperFormatStyle: IntegerFormatStyle<Bound> = IntegerFormatStyle() ) {
            self.showWithCloseSection = showWithCloseSection
            self.type = type
            self.lowerFormatStyle = lowerFormatStyle
            self.upperFormatStyle = upperFormatStyle
        }

        public func format(_ value: FormatInput) -> FormatOutput {
            let (lowerValue, upperValue) = values(value)

            return type.typePrefix + lowerFormatStyle.format(lowerValue) +
            type.typeMiddle(close: showWithCloseSection) + upperFormatStyle.format(upperValue) + type.typePostfix(close: showWithCloseSection)
        }
        
        func values(_ range: Range<Bound>) -> (Bound, Bound) {
            if showWithCloseSection { return (range.lowerBound, range.upperBound-1) }
            return (range.lowerBound, range.upperBound)
        }
    }
}
