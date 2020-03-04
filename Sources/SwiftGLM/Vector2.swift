//
//  Vector2.swift
//  SwiftGLM
//
//  Created by Josef Zoller on 03.03.20.
//

import cglm

public struct Vector2 {
    @usableFromInline internal var raw: vec2s
    
    @usableFromInline internal init(raw: vec2s) {
        self.raw = raw
    }
    
    
    @inlinable public init() {
        self.raw = vec2s()
    }
    
    @inlinable public init(_ value: Float) {
        self.raw = glms_vec2_fill(value)
    }
    
    @inlinable public init(from vec3: Vector3) {
        self.raw = glms_vec2(vec3.raw)
    }
    
    @inlinable public init(x: Float, y: Float) {
        self.raw = vec2s()
        self.raw.x = x
        self.raw.y = y
    }
    
    
    @inlinable public static var zero: Vector2 {
        .init(raw: glms_vec2_zero())
    }
    
    @inlinable public static var one: Vector2 {
        .init(raw: glms_vec2_one())
    }
    
    
    @inlinable public var x: Float { raw.x }
    @inlinable public var y: Float { raw.y }
    
    @inlinable public var max: Float { glms_vec2_max(raw) }
    @inlinable public var min: Float { glms_vec2_min(raw) }
    
    @inlinable public var isNaN: Bool { glms_vec2_isnan(raw) }
    @inlinable public var isInfinity: Bool { glms_vec2_isinf(raw) }
    
    @inlinable public var isValid: Bool { glms_vec2_isvalid(raw) }
    
    @inlinable public var squaredNorm: Float { glms_vec2_norm2(raw) }
    @inlinable public var norm: Float { glms_vec2_norm(raw) }
    
    @inlinable public var sign: Vector2 {
        .init(raw: glms_vec2_sign(raw))
    }
    
    @inlinable public var sqrt: Vector2 {
        .init(raw: glms_vec2_sqrt(raw))
    }
    
    @inlinable public var negated: Vector2 {
        .init(raw: glms_vec2_negate(raw))
    }
    
    @inlinable public var normalized: Vector2 {
        .init(raw: glms_vec2_normalize(raw))
    }
    
    
    @inlinable public mutating func scale(by s: Float) {
        raw = glms_vec2_scale(raw, s)
    }
    
    @inlinable public func scaled(by s: Float) -> Vector2 {
        .init(raw: glms_vec2_scale(raw, s))
    }
    
    @inlinable public mutating func scaleAsSpecified(by s: Float) {
        raw = glms_vec2_scale_as(raw, s)
    }
    
    @inlinable public func scaledAsSpecified(by s: Float) -> Vector2 {
        .init(raw: glms_vec2_scale_as(raw, s))
    }
    
    @inlinable public mutating func negate() {
        raw = glms_vec2_negate(raw)
    }
    
    @inlinable public mutating func normalize() {
        raw = glms_vec2_normalize(raw)
    }
    
    @inlinable public mutating func rotate(by angle: Float) {
        raw = glms_vec2_rotate(raw, angle)
    }
    
    @inlinable public func rotated(by angle: Float) -> Vector2 {
        .init(raw: glms_vec2_rotate(raw, angle))
    }
    
    @inlinable public mutating func clamp(between min: Float, and max: Float) {
        raw = glms_vec2_clamp(raw, min, max)
    }
    
    @inlinable public func squaredDistance(to other: Vector2) -> Float {
        glms_vec2_distance2(raw, other.raw)
    }
    
    @inlinable public func distance(to other: Vector2) -> Float {
        glms_vec2_distance(raw, other.raw)
    }
    
    @inlinable public func lerp(to: Vector2, interpolant t: Float) -> Vector2 {
        .init(raw: glms_vec2_lerp(raw, to.raw, t))
    }
    
    
    @inlinable public func dotProduct(with other: Vector2) -> Float {
        glms_vec2_dot(raw, other.raw)
    }
    
    @inlinable public func crossProduct(with other: Vector2) -> Float {
        glms_vec2_cross(raw, other.raw)
    }
    
    @inlinable public mutating func add(sumOf a: Vector2, and b: Vector2) {
        raw = glms_vec2_addadd(a.raw, b.raw, raw)
    }
    
    @inlinable public mutating func add(differenceOf a: Vector2, and b: Vector2) {
        raw = glms_vec2_subadd(a.raw, b.raw, raw)
    }
    
    @inlinable public mutating func add(productOf a: Vector2, and b: Vector2) {
        raw = glms_vec2_muladd(a.raw, b.raw, raw)
    }
    
    @inlinable public mutating func add(productOf a: Vector2, and b: Float) {
        raw = glms_vec2_muladds(a.raw, b, raw)
    }
    
    @inlinable public mutating func add(maxOf a: Vector2, and b: Vector2) {
        raw = glms_vec2_maxadd(a.raw, b.raw, raw)
    }
    
    @inlinable public mutating func add(minOf a: Vector2, and b: Vector2) {
        raw = glms_vec2_minadd(a.raw, b.raw, raw)
    }
    
    
    @inlinable public static func maxValues(of a: Vector2, and b: Vector2) -> Vector2 {
        .init(raw: glms_vec2_maxv(a.raw, b.raw))
    }
    
    @inlinable public static func minValues(of a: Vector2, and b: Vector2) -> Vector2 {
        .init(raw: glms_vec2_minv(a.raw, b.raw))
    }
    
    @inlinable public static func +(lhs: Vector2, rhs: Vector2) -> Vector2 {
        .init(raw: glms_vec2_add(lhs.raw, rhs.raw))
    }
    
    @inlinable public static func +(lhs: Vector2, rhs: Float) -> Vector2 {
        .init(raw: glms_vec2_adds(lhs.raw, rhs))
    }
    
    @inlinable public static func -(lhs: Vector2, rhs: Vector2) -> Vector2 {
        .init(raw: glms_vec2_sub(lhs.raw, rhs.raw))
    }
    
    @inlinable public static func -(lhs: Vector2, rhs: Float) -> Vector2 {
        .init(raw: glms_vec2_subs(lhs.raw, rhs))
    }
    
    @inlinable public static func *(lhs: Vector2, rhs: Vector2) -> Vector2 {
        .init(raw: glms_vec2_mul(lhs.raw, rhs.raw))
    }
    
    @inlinable public static func /(lhs: Vector2, rhs: Vector2) -> Vector2 {
        .init(raw: glms_vec2_div(lhs.raw, rhs.raw))
    }
    
    @inlinable public static func /(lhs: Vector2, rhs: Float) -> Vector2 {
        .init(raw: glms_vec2_divs(lhs.raw, rhs))
    }
    
    @inlinable public static prefix func -(rhs: Vector2) -> Vector2 {
        rhs.negated
    }
}

extension Vector2: Equatable {
    @inlinable public var membersAreEqual: Bool { glms_vec2_eq_all(raw) }
    
    
    @inlinable public func isNearlyEqual(to other: Vector2) -> Bool {
        glms_vec2_eqv_eps(raw, other.raw)
    }
    
    @inlinable public func isNearlyEqual(to value: Float) -> Bool {
        glms_vec2_eq_eps(raw, value)
    }
    
    
    @inlinable public static func ==(lhs: Vector2, rhs: Vector2) -> Bool {
        glms_vec2_eqv(lhs.raw, rhs.raw)
    }
    
    @inlinable public static func ==(lhs: Vector2, rhs: Float) -> Bool {
        glms_vec2_eq(lhs.raw, rhs)
    }
}
