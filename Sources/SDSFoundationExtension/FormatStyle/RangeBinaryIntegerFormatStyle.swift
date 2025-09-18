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
            let lower = value.lowerBound
            let upper = value.upperBound

            switch type {
            case .minus:
                if showWithCloseSection {
                    return lowerFormatStyle.format(lower) + "-" + upperFormatStyle.format(upper-1)
                } else {
                    return lowerFormatStyle.format(lower) + "-" + upperFormatStyle.format(upper)
                }
            case .math:
                if showWithCloseSection {
                    return "[" + lowerFormatStyle.format(lower) + "," + upperFormatStyle.format(upper-1) + "]"
                } else {
                    return "[" + lowerFormatStyle.format(lower) + "," + upperFormatStyle.format(upper) + ")"
                }
            case .swift:
                if showWithCloseSection {
                    return "\(lower)...\(upper-1)"
                } else {
                    return "\(lower)..<\(upper)"
                }
            }
        }
    }
}
