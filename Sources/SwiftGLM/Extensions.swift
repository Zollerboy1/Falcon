//
//  Extensions.swift
//  SwiftGLM
//
//  Created by Josef Zoller on 03.03.20.
//

import cglm
import Foundation

public extension String.StringInterpolation {
    @inlinable mutating func appendInterpolation(_ value: Float, withPrecision precision: Int) {
        appendLiteral(String(format: "%0.\(precision)f", value))
    }
}

public extension Int32 {
    @inlinable var sign: Int32 { glm_sign(self) }
}

public extension Float {
    @inlinable var sign: Float { glm_signf(self) }
    
    @inlinable var rad: Float { glm_rad(self) }
    @inlinable var deg: Float { glm_deg(self) }
    
    @inlinable var pow2: Float { glm_pow2(self) }
    
    @inlinable var clamped: Float { glm_clamp_zo(self) }
    
    @inlinable mutating func toRad() {
        glm_make_rad(&self)
    }
    
    @inlinable mutating func toDeg() {
        glm_make_deg(&self)
    }
    
    @inlinable mutating func step(withTreshold edge: Float) {
        self = glm_step(edge, self)
    }
    
    @inlinable func stepped(withTreshold edge: Float) -> Float {
        glm_step(edge, self)
    }
    
    @inlinable mutating func smoothStep(withLowTreshold edge0: Float, highTreshold edge1: Float) {
        self = glm_smoothstep(edge0, edge1, self)
    }
    
    @inlinable func smoothStepped(withLowTreshold edge0: Float, highTreshold edge1: Float) -> Float {
        glm_smoothstep(edge0, edge1, self)
    }
    
    @inlinable mutating func clamp(between min: Float, and max: Float) {
        self = glm_clamp(self, min, max)
    }
    
    @inlinable func clamped(between min: Float, and max: Float) -> Float {
        glm_clamp(self, min, max)
    }
    
    @inlinable mutating func clamp() {
        self = glm_clamp_zo(self)
    }
    
    @inlinable mutating func swap(with other: inout Float) {
        glm_swapf(&self, &other)
    }
    
    @inlinable func percentage(between from: Float, and to: Float) -> Float {
        glm_percent(from, to, self)
    }
    
    @inlinable func clampedPercentage(between from: Float, and to: Float) -> Float {
        glm_percentc(from, to, self)
    }
    
    @inlinable func lerp(to: Float, interpolant t: Float) -> Float {
        glm_lerp(self, to, t)
    }
    
    @inlinable func lerp(to: Float, clampedInterpolant t: Float) -> Float {
        glm_lerpc(self, to, t)
    }
    
    @inlinable func hermiteInterpolation(to: Float, interpolant t: Float) -> Float {
        glm_smoothinterp(self, to, t)
    }
    
    @inlinable func hermiteInterpolation(to: Float, clampedInterpolant t: Float) -> Float {
        glm_smoothinterpc(self, to, t)
    }
    
    
    @inlinable func isNearlyEqual(to value: Float) -> Bool {
        glm_eq(self, value)
    }
}
