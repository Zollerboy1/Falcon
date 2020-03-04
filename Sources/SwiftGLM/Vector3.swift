//
//  Vector3.swift
//  SwiftGLM
//
//  Created by Josef Zoller on 03.03.20.
//

import cglm

public struct Vector3 {
    public struct ShuffleMask {
        @usableFromInline internal let value: Int32
        
        @inlinable public init(z: Int, y: Int, x: Int) {
            assert((0...2).contains(z) && (0...2).contains(y) && (0...2).contains(x), "ShuffleMask values can only range between 0 and 2")
            
            self.value = (Int32(z) << 4) | (Int32(y) << 2) | Int32(x)
        }
        
        public static let xxx = ShuffleMask(z: 0, y: 0, x: 0)
        public static let yyy = ShuffleMask(z: 1, y: 1, x: 1)
        public static let zzz = ShuffleMask(z: 2, y: 2, x: 2)
        public static let zyx = ShuffleMask(z: 0, y: 1, x: 2)
    }
    
    
    @usableFromInline internal var raw: vec3s
    
    @usableFromInline internal init(raw: vec3s) {
        self.raw = raw
    }
    
    
    @inlinable public init() {
        self.raw = vec3s()
    }
    
    @inlinable public init(_ value: Float) {
        self.raw = glms_vec3_fill(value)
    }
    
    @inlinable public init(from vec4: Vector4) {
        self.raw = glms_vec3(vec4.raw)
    }
    
    @inlinable public init(x: Float, y: Float, z: Float) {
        self.raw = vec3s()
        self.raw.x = x
        self.raw.y = y
        self.raw.z = z
    }
    
    
    @inlinable public static var zero: Vector3 {
        .init(raw: glms_vec3_zero())
    }
    
    @inlinable public static var one: Vector3 {
        .init(raw: glms_vec3_one())
    }
    
    
    @inlinable public var x: Float { raw.x }
    @inlinable public var y: Float { raw.y }
    @inlinable public var z: Float { raw.z }
    
    @inlinable public var r: Float { raw.x }
    @inlinable public var g: Float { raw.y }
    @inlinable public var b: Float { raw.z }
    
    @inlinable public var luminance: Float { glms_luminance(raw) }
    
    @inlinable public var eulerXYZ: Matrix4 { .init(raw: glms_euler_xyz(raw)) }
    @inlinable public var eulerXZY: Matrix4 { .init(raw: glms_euler_xzy(raw)) }
    @inlinable public var eulerYXZ: Matrix4 { .init(raw: glms_euler_yxz(raw)) }
    @inlinable public var eulerYZX: Matrix4 { .init(raw: glms_euler_yzx(raw)) }
    @inlinable public var eulerZXY: Matrix4 { .init(raw: glms_euler_zxy(raw)) }
    @inlinable public var eulerZYX: Matrix4 { .init(raw: glms_euler_zyx(raw)) }
    
    @inlinable public var max: Float { glms_vec3_max(raw) }
    @inlinable public var min: Float { glms_vec3_min(raw) }
    
    @inlinable public var isNaN: Bool { glms_vec3_isnan(raw) }
    @inlinable public var isInfinity: Bool { glms_vec3_isinf(raw) }
    
    @inlinable public var isValid: Bool { glms_vec3_isvalid(raw) }
    
    @inlinable public var sum: Float { glms_vec3_hadd(raw) }
    
    @inlinable public var squaredNorm: Float { glms_vec3_norm2(raw) }
    @inlinable public var norm: Float { glms_vec3_norm(raw) }
    @inlinable public var taxicabNorm: Float { glms_vec3_norm_one(raw) }
    @inlinable public var maximumNorm: Float { glms_vec3_norm_inf(raw) }
    
    @inlinable public var sign: Vector3 {
        .init(raw: glms_vec3_sign(raw))
    }
    
    @inlinable public var abs: Vector3 {
        .init(raw: glms_vec3_abs(raw))
    }
    
    @inlinable public var fract: Vector3 {
        .init(raw: glms_vec3_fract(raw))
    }
    
    @inlinable public var sqrt: Vector3 {
        .init(raw: glms_vec3_sqrt(raw))
    }
    
    @inlinable public var negated: Vector3 {
        .init(raw: glms_vec3_negate(raw))
    }
    
    @inlinable public var normalized: Vector3 {
        .init(raw: glms_vec3_normalize(raw))
    }
    
    @inlinable public var orthogonal: Vector3 {
        .init(raw: glms_vec3_ortho(raw))
    }
    
    
    @inlinable public func euler(byOrder order: EulerOrder) -> Matrix4 {
        .init(raw: glms_euler_by_order(raw, order.raw))
    }
    
    @inlinable public func unprojected(withInvertedProjection m: Matrix4, viewport: Vector4) -> Vector3 {
        .init(raw: glms_unprojecti(raw, m.raw, viewport.raw))
    }
    
    @inlinable public func unprojected(withProjection m: Matrix4, viewport: Vector4) -> Vector3 {
        .init(raw: glms_unproject(raw, m.raw, viewport.raw))
    }
    
    @inlinable public func projected(withModelViewProjection m: Matrix4, viewport: Vector4) -> Vector3 {
        .init(raw: glms_project(raw, m.raw, viewport.raw))
    }
    
    @inlinable public mutating func scale(by s: Float) {
        raw = glms_vec3_scale(raw, s)
    }
    
    @inlinable public func scaled(by s: Float) -> Vector3 {
        .init(raw: glms_vec3_scale(raw, s))
    }
    
    @inlinable public mutating func scaleAsSpecified(by s: Float) {
        raw = glms_vec3_scale_as(raw, s)
    }
    
    @inlinable public func scaledAsSpecified(by s: Float) -> Vector3 {
        .init(raw: glms_vec3_scale_as(raw, s))
    }
    
    @inlinable public mutating func negate() {
        raw = glms_vec3_negate(raw)
    }
    
    @inlinable public mutating func normalize() {
        raw = glms_vec3_normalize(raw)
    }
    
    @inlinable public mutating func rotate(using q: Versors) {
        raw = glms_quat_rotatev(q.raw, raw)
    }
    
    @inlinable public func rotated(using q: Versors) -> Vector3 {
        .init(raw: glms_quat_rotatev(q.raw, raw))
    }
    
    @inlinable public mutating func rotate(by angle: Float, axis: Vector3) {
        raw = glms_vec3_rotate(raw, angle, axis.raw)
    }
    
    @inlinable public mutating func rotate(applying m: Matrix4) {
        raw = glms_vec3_rotate_m4(m.raw, raw)
    }
    
    @inlinable public func rotated(applying m: Matrix4) -> Vector3 {
        .init(raw: glms_vec3_rotate_m4(m.raw, raw))
    }
    
    @inlinable public mutating func rotate(applying m: Matrix3) {
        raw = glms_vec3_rotate_m3(m.raw, raw)
    }
    
    @inlinable public func rotated(applying m: Matrix3) -> Vector3 {
        .init(raw: glms_vec3_rotate_m3(m.raw, raw))
    }
    
    @inlinable public mutating func step(withTreshold edge: Vector3) {
        raw = glms_vec3_step(edge.raw, raw)
    }
    
    @inlinable public func stepped(withTreshold edge: Vector3) -> Vector3 {
        .init(raw: glms_vec3_step(edge.raw, raw))
    }
    
    @inlinable public mutating func unidimensionalStep(withTreshold edge: Float) {
        raw = glms_vec3_step_uni(edge, raw)
    }
    
    @inlinable public func unidimensionalStepped(withTreshold edge: Float) -> Vector3 {
        .init(raw: glms_vec3_step_uni(edge, raw))
    }
    
    @inlinable public mutating func smoothStep(withLowTreshold edge0: Vector3, highTreshold edge1: Vector3) {
        raw = glms_vec3_smoothstep(edge0.raw, edge1.raw, raw)
    }
    
    @inlinable public func smoothStepped(withLowTreshold edge0: Vector3, highTreshold edge1: Vector3) -> Vector3 {
        .init(raw: glms_vec3_smoothstep(edge0.raw, edge1.raw, raw))
    }
    
    @inlinable public mutating func unidimensionalSmoothStep(withLowTreshold edge0: Float, highTreshold edge1: Float) {
        raw = glms_vec3_smoothstep_uni(edge0, edge1, raw)
    }
    
    @inlinable public func unidimensionalSmoothStepped(withLowTreshold edge0: Float, highTreshold edge1: Float) -> Vector3 {
        .init(raw: glms_vec3_smoothstep_uni(edge0, edge1, raw))
    }
    
    @inlinable public mutating func project(onto other: Vector3) {
        raw = glms_vec3_proj(raw, other.raw)
    }
    
    @inlinable public func projected(onto other: Vector3) -> Vector3 {
        .init(raw: glms_vec3_proj(raw, other.raw))
    }
    
    @inlinable public mutating func swizzle(using mask: ShuffleMask) {
        raw = glms_vec3_swizzle(raw, mask.value)
    }
    
    @inlinable public func swizzled(using mask: ShuffleMask) -> Vector3 {
        .init(raw: glms_vec3_swizzle(raw, mask.value))
    }
    
    @inlinable public mutating func clamp(between min: Float, and max: Float) {
        raw = glms_vec3_clamp(raw, min, max)
    }
    
    @inlinable public func halfWay(to other: Vector3) -> Vector3 {
        .init(raw: glms_vec3_center(raw, other.raw))
    }
    
    @inlinable public func angle(to other: Vector3) -> Float {
        glms_vec3_angle(raw, other.raw)
    }
    
    @inlinable public func squaredDistance(to other: Vector3) -> Float {
        glms_vec3_distance2(raw, other.raw)
    }
    
    @inlinable public func distance(to other: Vector3) -> Float {
        glms_vec3_distance(raw, other.raw)
    }
    
    @inlinable public func lerp(to: Vector3, interpolant t: Float) -> Vector3 {
        .init(raw: glms_vec3_lerp(raw, to.raw, t))
    }
    
    @inlinable public func lerp(to: Vector3, clampedInterpolant t: Float) -> Vector3 {
        .init(raw: glms_vec3_lerpc(raw, to.raw, t))
    }
    
    @inlinable public func hermiteInterpolation(to: Vector3, interpolant t: Float) -> Vector3 {
        .init(raw: glms_vec3_smoothinterp(raw, to.raw, t))
    }
    
    @inlinable public func hermiteInterpolation(to: Vector3, clampedInterpolant t: Float) -> Vector3 {
        .init(raw: glms_vec3_smoothinterpc(raw, to.raw, t))
    }
    
    
    @inlinable public func dotProduct(with other: Vector3) -> Float {
        glms_vec3_dot(raw, other.raw)
    }
    
    @inlinable public func crossProduct(with other: Vector3) -> Vector3 {
        .init(raw: glms_vec3_cross(raw, other.raw))
    }
    
    @inlinable public func normalizedCrossProduct(with other: Vector3) -> Vector3 {
        .init(raw: glms_vec3_crossn(raw, other.raw))
    }
    
    @inlinable public mutating func add(sumOf a: Vector3, and b: Vector3) {
        glms_vec3_addadd(a.raw, b.raw, raw)
    }
    
    @inlinable public mutating func add(differenceOf a: Vector3, and b: Vector3) {
        glms_vec3_subadd(a.raw, b.raw, raw)
    }
    
    @inlinable public mutating func add(productOf a: Vector3, and b: Vector3) {
        glms_vec3_muladd(a.raw, b.raw, raw)
    }
    
    @inlinable public mutating func add(productOf a: Vector3, and b: Float) {
        glms_vec3_muladds(a.raw, b, raw)
    }
    
    @inlinable public mutating func add(maxOf a: Vector3, and b: Vector3) {
        glms_vec3_maxadd(a.raw, b.raw, raw)
    }
    
    @inlinable public mutating func add(minOf a: Vector3, and b: Vector3) {
        glms_vec3_minadd(a.raw, b.raw, raw)
    }
    
    
    @inlinable public static func maxValues(of a: Vector3, and b: Vector3) -> Vector3 {
        .init(raw: glms_vec3_maxv(a.raw, b.raw))
    }
    
    @inlinable public static func minValues(of a: Vector3, and b: Vector3) -> Vector3 {
        .init(raw: glms_vec3_minv(a.raw, b.raw))
    }
    
    @inlinable public static func +(lhs: Vector3, rhs: Vector3) -> Vector3 {
        .init(raw: glms_vec3_add(lhs.raw, rhs.raw))
    }
    
    @inlinable public static func +(lhs: Vector3, rhs: Float) -> Vector3 {
        .init(raw: glms_vec3_adds(lhs.raw, rhs))
    }
    
    @inlinable public static func -(lhs: Vector3, rhs: Vector3) -> Vector3 {
        .init(raw: glms_vec3_sub(lhs.raw, rhs.raw))
    }
    
    @inlinable public static func -(lhs: Vector3, rhs: Float) -> Vector3 {
        .init(raw: glms_vec3_subs(lhs.raw, rhs))
    }
    
    @inlinable public static func *(lhs: Vector3, rhs: Vector3) -> Vector3 {
        .init(raw: glms_vec3_mul(lhs.raw, rhs.raw))
    }
    
    @inlinable public static func /(lhs: Vector3, rhs: Vector3) -> Vector3 {
        .init(raw: glms_vec3_div(lhs.raw, rhs.raw))
    }
    
    @inlinable public static func /(lhs: Vector3, rhs: Float) -> Vector3 {
        .init(raw: glms_vec3_divs(lhs.raw, rhs))
    }
}


extension Vector3: CustomStringConvertible {
    @inlinable public var description: String {
        "Vector (float3):\n\t| \(x, withPrecision: 4)\t\(y, withPrecision: 4)\t\(z, withPrecision: 4) |\n"
    }
}

extension Vector3: Equatable {
    @inlinable public var membersAreEqual: Bool { glms_vec3_eq_all(raw) }
    
    
    @inlinable public func isNearlyEqual(to other: Vector3) -> Bool {
        glms_vec3_eqv_eps(raw, other.raw)
    }
    
    @inlinable public func isNearlyEqual(to value: Float) -> Bool {
        glms_vec3_eq_eps(raw, value)
    }
    
    
    @inlinable public static func ==(lhs: Vector3, rhs: Vector3) -> Bool {
        glms_vec3_eqv(lhs.raw, rhs.raw)
    }
    
    @inlinable public static func ==(lhs: Vector3, rhs: Float) -> Bool {
        glms_vec3_eq(lhs.raw, rhs)
    }
}
