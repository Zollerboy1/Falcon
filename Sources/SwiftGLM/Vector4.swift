//
//  Vector4.swift
//  SwiftGLM
//
//  Created by Josef Zoller on 03.03.20.
//

import cglm

public struct Vector4 {
    public struct ShuffleMask {
        @usableFromInline internal let value: Int32
        
        @inlinable public init(z: Int, y: Int, x: Int, w: Int) {
            assert((0...3).contains(z) && (0...3).contains(y) && (0...3).contains(x) && (0...3).contains(w), "ShuffleMask values can only range between 0 and 3")
            
            self.value = (Int32(z) << 6) | (Int32(y) << 4) | (Int32(x) << 2) | Int32(w)
        }
        
        public static let xxxx = ShuffleMask(z: 0, y: 0, x: 0, w: 0)
        public static let yyyy = ShuffleMask(z: 1, y: 1, x: 1, w: 1)
        public static let zzzz = ShuffleMask(z: 2, y: 2, x: 2, w: 2)
        public static let wwww = ShuffleMask(z: 3, y: 3, x: 3, w: 3)
        public static let wzyx = ShuffleMask(z: 0, y: 1, x: 2, w: 3)
    }
    
    
    @usableFromInline internal var raw: vec4s
    
    @usableFromInline internal init(raw: vec4s) {
        self.raw = raw
    }
    
    
    @inlinable public init() {
        self.raw = vec4s()
    }
    
    @inlinable public init(_ value: Float) {
        self.raw = glms_vec4_fill(value)
    }
    
    @inlinable public init(cubic value: Float) {
        self.raw = glms_vec4_cubic(value)
    }
    
    @inlinable public init(from vec3: Vector3, last: Float) {
        self.raw = glms_vec4(vec3.raw, last)
    }
    
    @inlinable public init(x: Float, y: Float, z: Float, w: Float) {
        self.raw = vec4s()
        self.raw.x = x
        self.raw.y = y
        self.raw.z = z
        self.raw.w = w
    }
    
    @inlinable public init(r: Float, g: Float, b: Float, a: Float) {
        self.raw = vec4s()
        self.raw.x = r
        self.raw.y = g
        self.raw.z = b
        self.raw.w = a
    }
    
    
    @inlinable public static var clipSpaceCoordinateLBN: Vector4 {
        .init(x: -1, y: -1, z: -1, w: 1)
    }
    
    @inlinable public static var clipSpaceCoordinateLTN: Vector4 {
        .init(x: -1, y: 1, z: -1, w: 1)
    }
    
    @inlinable public static var clipSpaceCoordinateRTN: Vector4 {
        .init(x: 1, y: 1, z: -1, w: 1)
    }
    
    @inlinable public static var clipSpaceCoordinateRBN: Vector4 {
        .init(x: 1, y: -1, z: -1, w: 1)
    }
    
    @inlinable public static var clipSpaceCoordinateLBF: Vector4 {
        .init(x: -1, y: -1, z: 1, w: 1)
    }
    
    @inlinable public static var clipSpaceCoordinateLTF: Vector4 {
        .init(x: -1, y: 1, z: 1, w: 1)
    }
    
    @inlinable public static var clipSpaceCoordinateRTF: Vector4 {
        .init(x: 1, y: 1, z: 1, w: 1)
    }
    
    @inlinable public static var clipSpaceCoordinateRBF: Vector4 {
        .init(x: 1, y: -1, z: 1, w: 1)
    }
    
    @inlinable public static var zero: Vector4 {
        .init(raw: glms_vec4_zero())
    }
    
    @inlinable public static var one: Vector4 {
        .init(raw: glms_vec4_one())
    }
    
    
    @inlinable public var x: Float { raw.x }
    @inlinable public var y: Float { raw.y }
    @inlinable public var z: Float { raw.z }
    @inlinable public var w: Float { raw.w }
    
    @inlinable public var sphereCenterX: Float { raw.x }
    @inlinable public var sphereCenterY: Float { raw.y }
    @inlinable public var sphereCenterZ: Float { raw.z }
    @inlinable public var sphereRadius: Float { raw.w }
    
    @inlinable public var r: Float { raw.x }
    @inlinable public var g: Float { raw.y }
    @inlinable public var b: Float { raw.z }
    @inlinable public var a: Float { raw.w }
    
    @inlinable public var max: Float { glms_vec4_max(raw) }
    @inlinable public var min: Float { glms_vec4_min(raw) }
    
    @inlinable public var isNaN: Bool { glms_vec4_isnan(raw) }
    @inlinable public var isInfinity: Bool { glms_vec4_isinf(raw) }
    
    @inlinable public var isValid: Bool { glms_vec4_isvalid(raw) }
    
    @inlinable public var sum: Float { glms_vec4_hadd(raw) }
    
    @inlinable public var squaredNorm: Float { glms_vec4_norm2(raw) }
    @inlinable public var norm: Float { glms_vec4_norm(raw) }
    @inlinable public var taxicabNorm: Float { glms_vec4_norm_one(raw) }
    @inlinable public var maximumNorm: Float { glms_vec4_norm_inf(raw) }
    
    @inlinable public var sign: Vector4 {
        .init(raw: glms_vec4_sign(raw))
    }
    
    @inlinable public var abs: Vector4 {
        .init(raw: glms_vec4_abs(raw))
    }
    
    @inlinable public var fract: Vector4 {
        .init(raw: glms_vec4_fract(raw))
    }
    
    @inlinable public var sqrt: Vector4 {
        .init(raw: glms_vec4_sqrt(raw))
    }
    
    @inlinable public var negated: Vector4 {
        .init(raw: glms_vec4_negate(raw))
    }
    
    @inlinable public var normalized: Vector4 {
        .init(raw: glms_vec4_normalize(raw))
    }
    
    @inlinable public var unalignedCopy: Vector4 {
        .init(raw: glms_vec4_ucopy(raw))
    }
    
    @inlinable public var copy: Vector4 {
        .init(raw: glms_vec4_copy(raw))
    }
    
    @inlinable public var copyVec3: Vector3 {
        .init(raw: glms_vec4_copy3(raw))
    }
    
    
    @inlinable public mutating func normalizePlane() {
        raw = glms_plane_normalize(raw)
    }
    
    @inlinable public mutating func transformSphere(using m: Matrix4) {
        raw = glms_sphere_transform(raw, m.raw)
    }
    
    @inlinable public func transformedSphere(using m: Matrix4) -> Vector4 {
        .init(raw: glms_sphere_transform(raw, m.raw))
    }
    
    @inlinable public mutating func merge(withOtherSphere s: Vector4) {
        raw = glms_sphere_merge(raw, s.raw)
    }
    
    @inlinable public func merged(withOtherSphere s: Vector4) -> Vector4 {
        .init(raw: glms_sphere_merge(raw, s.raw))
    }
    
    @inlinable public mutating func scale(by s: Float) {
        raw = glms_vec4_scale(raw, s)
    }
    
    @inlinable public func scaled(by s: Float) -> Vector4 {
        .init(raw: glms_vec4_scale(raw, s))
    }
    
    @inlinable public mutating func scaleAsSpecified(by s: Float) {
        raw = glms_vec4_scale_as(raw, s)
    }
    
    @inlinable public func scaledAsSpecified(by s: Float) -> Vector4 {
        .init(raw: glms_vec4_scale_as(raw, s))
    }
    
    @inlinable public mutating func negate() {
        raw = glms_vec4_negate(raw)
    }
    
    @inlinable public mutating func normalize() {
        raw = glms_vec4_normalize(raw)
    }
    
    @inlinable public mutating func step(withTreshold edge: Vector4) {
        raw = glms_vec4_step(edge.raw, raw)
    }
    
    @inlinable public func stepped(withTreshold edge: Vector4) -> Vector4 {
        .init(raw: glms_vec4_step(edge.raw, raw))
    }
    
    @inlinable public mutating func unidimensionalStep(withTreshold edge: Float) {
        raw = glms_vec4_step_uni(edge, raw)
    }
    
    @inlinable public func unidimensionalStepped(withTreshold edge: Float) -> Vector4 {
        .init(raw: glms_vec4_step_uni(edge, raw))
    }
    
    @inlinable public mutating func smoothStep(withLowTreshold edge0: Vector4, highTreshold edge1: Vector4) {
        raw = glms_vec4_smoothstep(edge0.raw, edge1.raw, raw)
    }
    
    @inlinable public func smoothStepped(withLowTreshold edge0: Vector4, highTreshold edge1: Vector4) -> Vector4 {
        .init(raw: glms_vec4_smoothstep(edge0.raw, edge1.raw, raw))
    }
    
    @inlinable public mutating func unidimensionalSmoothStep(withLowTreshold edge0: Float, highTreshold edge1: Float) {
        raw = glms_vec4_smoothstep_uni(edge0, edge1, raw)
    }
    
    @inlinable public func unidimensionalSmoothStepped(withLowTreshold edge0: Float, highTreshold edge1: Float) -> Vector4 {
        .init(raw: glms_vec4_smoothstep_uni(edge0, edge1, raw))
    }
    
    @inlinable public mutating func swizzle(using mask: ShuffleMask) {
        raw = glms_vec4_swizzle(raw, mask.value)
    }
    
    @inlinable public func swizzled(using mask: ShuffleMask) -> Vector4 {
        .init(raw: glms_vec4_swizzle(raw, mask.value))
    }
    
    @inlinable public mutating func clamp(between min: Float, and max: Float) {
        raw = glms_vec4_clamp(raw, min, max)
    }
    
    @inlinable public func sphereIntersects(with other: Vector4) -> Bool {
        glms_sphere_sphere(raw, other.raw)
    }
    
    @inlinable public func sphereIntersects(withPoint p: Vector3) -> Bool {
        glms_sphere_point(raw, p.raw)
    }
    
    @inlinable public func squaredDistance(to other: Vector4) -> Float {
        glms_vec4_distance2(raw, other.raw)
    }
    
    @inlinable public func distance(to other: Vector4) -> Float {
        glms_vec4_distance(raw, other.raw)
    }
    
    @inlinable public func lerp(to: Vector4, interpolant t: Float) -> Vector4 {
        .init(raw: glms_vec4_lerp(raw, to.raw, t))
    }
    
    @inlinable public func lerp(to: Vector4, clampedInterpolant t: Float) -> Vector4 {
        .init(raw: glms_vec4_lerpc(raw, to.raw, t))
    }
    
    @inlinable public func hermiteInterpolation(to: Vector4, interpolant t: Float) -> Vector4 {
        .init(raw: glms_vec4_smoothinterp(raw, to.raw, t))
    }
    
    @inlinable public func hermiteInterpolation(to: Vector4, clampedInterpolant t: Float) -> Vector4 {
        .init(raw: glms_vec4_smoothinterpc(raw, to.raw, t))
    }
    
    
    @inlinable public func dotProduct(with other: Vector4) -> Float {
        glms_vec4_dot(raw, other.raw)
    }
    
    @inlinable public mutating func add(sumOf a: Vector4, and b: Vector4) {
        glms_vec4_addadd(a.raw, b.raw, raw)
    }
    
    @inlinable public mutating func add(differenceOf a: Vector4, and b: Vector4) {
        glms_vec4_subadd(a.raw, b.raw, raw)
    }
    
    @inlinable public mutating func add(productOf a: Vector4, and b: Vector4) {
        glms_vec4_muladd(a.raw, b.raw, raw)
    }
    
    @inlinable public mutating func add(productOf a: Vector4, and b: Float) {
        glms_vec4_muladds(a.raw, b, raw)
    }
    
    @inlinable public mutating func add(maxOf a: Vector4, and b: Vector4) {
        glms_vec4_maxadd(a.raw, b.raw, raw)
    }
    
    @inlinable public mutating func add(minOf a: Vector4, and b: Vector4) {
        glms_vec4_minadd(a.raw, b.raw, raw)
    }
    
    
    @inlinable public static func maxValues(of a: Vector4, and b: Vector4) -> Vector4 {
        .init(raw: glms_vec4_maxv(a.raw, b.raw))
    }
    
    @inlinable public static func minValues(of a: Vector4, and b: Vector4) -> Vector4 {
        .init(raw: glms_vec4_minv(a.raw, b.raw))
    }
    
    @inlinable public static func +(lhs: Vector4, rhs: Float) -> Vector4 {
        .init(raw: glms_vec4_adds(lhs.raw, rhs))
    }
    
    @inlinable public static func -(lhs: Vector4, rhs: Vector4) -> Vector4 {
        .init(raw: glms_vec4_sub(lhs.raw, rhs.raw))
    }
    
    @inlinable public static func -(lhs: Vector4, rhs: Float) -> Vector4 {
        .init(raw: glms_vec4_subs(lhs.raw, rhs))
    }
    
    @inlinable public static func *(lhs: Vector4, rhs: Vector4) -> Vector4 {
        .init(raw: glms_vec4_mul(lhs.raw, rhs.raw))
    }
    
    @inlinable public static func /(lhs: Vector4, rhs: Vector4) -> Vector4 {
        .init(raw: glms_vec4_div(lhs.raw, rhs.raw))
    }
    
    @inlinable public static func /(lhs: Vector4, rhs: Float) -> Vector4 {
        .init(raw: glms_vec4_divs(lhs.raw, rhs))
    }
}


extension Vector4: CustomStringConvertible {
    @inlinable public var description: String {
        "Vector (float4):\n\t| \(x, withPrecision: 4)\t\(y, withPrecision: 4)\t\(z, withPrecision: 4)\t\(w, withPrecision: 4) |\n"
    }
}

extension Vector4: Equatable {
    @inlinable public var membersAreEqual: Bool { glms_vec4_eq_all(raw) }
    
    
    @inlinable public func isNearlyEqual(to other: Vector4) -> Bool {
        glms_vec4_eqv_eps(raw, other.raw)
    }
    
    @inlinable public func isNearlyEqual(to value: Float) -> Bool {
        glms_vec4_eq_eps(raw, value)
    }
    
    
    @inlinable public static func ==(lhs: Vector4, rhs: Vector4) -> Bool {
        glms_vec4_eqv(lhs.raw, rhs.raw)
    }
    
    @inlinable public static func ==(lhs: Vector4, rhs: Float) -> Bool {
        glms_vec4_eq(lhs.raw, rhs)
    }
}
