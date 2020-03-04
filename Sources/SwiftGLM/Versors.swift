//
//  Versors.swift
//  SwiftGLM
//
//  Created by Josef Zoller on 03.03.20.
//

import cglm

public struct Versors {
    @usableFromInline internal var raw: versors
    
    @usableFromInline internal init(raw: versors) {
        self.raw = raw
    }
    
    
    @inlinable public init() {
        self.raw = versors()
    }
    
    @inlinable public init(x: Float, y: Float, z: Float, w: Float) {
        self.raw = glms_quat_init(x, y, z, w)
    }
    
    @inlinable public init(imaginary: Vector3, real: Float) {
        self.raw = versors()
        self.raw.imag = imaginary.raw
        self.raw.real = real
    }
    
    @inlinable public init(withAngle angle: Float, axis: Vector3) {
        self.raw = glms_quatv(angle, axis.raw)
    }
    
    @inlinable public init(withAngle angle: Float, x: Float, y: Float, z: Float) {
        self.raw = glms_quat(angle, x, y, z)
    }
    
    
    @inlinable public static var identity: Versors {
        .init(raw: glms_quat_identity())
    }
    
    
    @inlinable public static func createLookRotation(withDirection dir: Vector3, up: Vector3) -> Versors {
        .init(raw: glms_quat_for(dir.raw, up.raw))
    }
    
    @inlinable public static func createLookRotation(from: Vector3, to: Vector3, up: Vector3) -> Versors {
        .init(raw: glms_quat_forp(from.raw, to.raw, up.raw))
    }
    
    
    @inlinable public var x: Float { raw.x }
    @inlinable public var y: Float { raw.y }
    @inlinable public var z: Float { raw.z }
    @inlinable public var w: Float { raw.w }
    
    @inlinable public var imaginary: Vector3 { .init(raw: raw.imag) }
    @inlinable public var real: Float { raw.real }
    
    @inlinable public var norm: Float { glms_quat_norm(raw) }
    @inlinable public var angle: Float { glms_quat_angle(raw) }
    
    @inlinable public var axis: Vector3 {
        .init(raw: glms_quat_axis(raw))
    }
    
    @inlinable public var conjugate: Versors {
        .init(raw: glms_quat_conjugate(raw))
    }
    
    @inlinable public var normalized: Versors {
        .init(raw: glms_quat_normalize(raw))
    }
    
    @inlinable public var inversed: Versors {
        .init(raw: glms_quat_inv(raw))
    }
    
    @inlinable public var normalizedImaginaryPart: Vector3 {
        .init(raw: glms_quat_imagn(raw))
    }
    
    @inlinable public var lengthOfImaginaryPart: Float {
        glms_quat_imaglen(raw)
    }
    
    @inlinable public var toMatrix4: Matrix4 {
        .init(raw: glms_quat_mat4(raw))
    }
    
    @inlinable public var toTransposedMatrix4: Matrix4 {
        .init(raw: glms_quat_mat4t(raw))
    }
    
    @inlinable public var toMatrix3: Matrix3 {
        .init(raw: glms_quat_mat3(raw))
    }
    
    @inlinable public var toTransposedMatrix3: Matrix3 {
        .init(raw: glms_quat_mat3t(raw))
    }
    
    
    @inlinable public mutating func normalize() {
        raw = glms_quat_normalize(raw)
    }
    
    @inlinable public mutating func inverse() {
        raw = glms_quat_inv(raw)
    }
    
    @inlinable public func lerp(to: Versors, interpolant t: Float) -> Versors {
        .init(raw: glms_quat_lerp(raw, to.raw, t))
    }
    
    @inlinable public func lerp(to: Versors, clampedInterpolant t: Float) -> Versors {
        .init(raw: glms_quat_lerpc(raw, to.raw, t))
    }
    
    @inlinable public func slerp(to: Versors, interpolant t: Float) -> Versors {
        .init(raw: glms_quat_slerp(raw, to.raw, t))
    }
    
    
    @inlinable public func dotProduct(with other: Versors) -> Float {
        glms_quat_dot(raw, other.raw)
    }
    
    @inlinable public static func +(lhs: Versors, rhs: Versors) -> Versors {
        .init(raw: glms_quat_add(lhs.raw, rhs.raw))
    }
    
    @inlinable public static func -(lhs: Versors, rhs: Versors) -> Versors {
        .init(raw: glms_quat_sub(lhs.raw, rhs.raw))
    }
    
    @inlinable public static func *(lhs: Versors, rhs: Versors) -> Versors {
        .init(raw: glms_quat_sub(lhs.raw, rhs.raw))
    }
}

extension Versors: CustomStringConvertible {
    @inlinable public var description: String {
        "Versor (float4):\n\t| \(x, withPrecision: 4)\t\(y, withPrecision: 4)\t\(z, withPrecision: 4)\t\(w, withPrecision: 4) |\n"
    }
}
