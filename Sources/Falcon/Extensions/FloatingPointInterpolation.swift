//
//  FloatingPointInterpolation.swift
//  Falcon
//
//  Created by Josef Zoller on 05.10.20.
//

import Logging

public extension DefaultStringInterpolation {
    mutating func appendInterpolation(_ value: Float, precision: Int) {
        self.appendInterpolation(String(format: "%.\(precision)g", value))
    }

    mutating func appendInterpolation(_ value: Double, precision: Int) {
        self.appendInterpolation(String(format: "%.\(precision)g", value))
    }
}
