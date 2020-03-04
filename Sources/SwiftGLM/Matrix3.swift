//
//  Matrix3.swift
//  SwiftGLM
//
//  Created by Josef Zoller on 03.03.20.
//

import cglm

public struct Matrix3 {
    @usableFromInline internal var raw: mat3s
    
    @usableFromInline internal init(raw: mat3s) {
        self.raw = raw
    }
    
    @inlinable public init() {
        self.raw = mat3s()
    }
    
    @inlinable public init(m00: Float, m01: Float, m02: Float, m10: Float, m11: Float, m12: Float, m20: Float, m21: Float, m22: Float) {
        self.raw = mat3s()
        self.raw.m00 = m00
        self.raw.m01 = m01
        self.raw.m02 = m02
        self.raw.m10 = m10
        self.raw.m11 = m11
        self.raw.m12 = m12
        self.raw.m20 = m20
        self.raw.m21 = m21
        self.raw.m22 = m22
    }
    
    @inlinable public init(col0: Vector3, col1: Vector3, col2: Vector3) {
        self.raw = mat3s()
        self.raw.col = (col0.raw, col1.raw, col2.raw)
    }
    
    @inlinable public static var identity: Matrix3 {
        .init(raw: glms_mat3_identity())
    }
    
    @inlinable public static var zero: Matrix3 {
        .init(raw: glms_mat3_zero())
    }
    
    @inlinable public var m00: Float { raw.m00 }
    @inlinable public var m01: Float { raw.m01 }
    @inlinable public var m02: Float { raw.m02 }
    @inlinable public var m10: Float { raw.m10 }
    @inlinable public var m11: Float { raw.m11 }
    @inlinable public var m12: Float { raw.m12 }
    @inlinable public var m20: Float { raw.m20 }
    @inlinable public var m21: Float { raw.m21 }
    @inlinable public var m22: Float { raw.m22 }
    
    @inlinable public var col0: Vector3 { .init(raw: raw.col.0) }
    @inlinable public var col1: Vector3 { .init(raw: raw.col.1) }
    @inlinable public var col2: Vector3 { .init(raw: raw.col.2) }
    
    @inlinable public var trace: Float { glms_mat3_trace(raw) }
    @inlinable public var quaternion: Versors { .init(raw: glms_mat3_quat(raw)) }
    @inlinable public var determinant: Float { glms_mat3_det(raw) }
    
    @inlinable public var inversed: Matrix3 {
        .init(raw: glms_mat3_inv(raw))
    }
    
    @inlinable public var transposed: Matrix3 {
        .init(raw: glms_mat3_transpose(raw))
    }
    
    @inlinable public var copy: Matrix3 {
        .init(raw: glms_mat3_copy(raw))
    }
    
    
    @inlinable public mutating func transpose() {
        raw = glms_mat3_transpose(raw)
    }
    
    @inlinable public mutating func scale(by s: Float) {
        raw = glms_mat3_scale(raw, s)
    }
    
    @inlinable public mutating func inverse() {
        raw = glms_mat3_inv(raw)
    }
    
    @inlinable public mutating func swap(columnWithNumber col0: Int, with col1: Int) {
        raw = glms_mat3_swap_col(raw, Int32(col0), Int32(col1))
    }
    
    @inlinable public mutating func swap(rowWithNumber row0: Int, with row1: Int) {
        raw = glms_mat3_swap_row(raw, Int32(row0), Int32(row1))
    }
    
    
    @inlinable public func rmc(row: Vector3, col: Vector3) -> Float {
        glms_mat3_rmc(row.raw, raw, col.raw)
    }
    
    
    @inlinable public static func *(lhs: Matrix3, rhs: Matrix3) -> Matrix3 {
        .init(raw: glms_mat3_mul(lhs.raw, rhs.raw))
    }
    
    @inlinable public static func *(lhs: Matrix3, rhs: Vector3) -> Vector3 {
        .init(raw: glms_mat3_mulv(lhs.raw, rhs.raw))
    }
}

extension Matrix3: CustomStringConvertible {
    @inlinable public var description: String {
        "Matrix (float3x3):\n\t| \(m00, withPrecision: 4)\t\(m10, withPrecision: 4)\t\(m20, withPrecision: 4) |\n\t| \(m01, withPrecision: 4)\t\(m11, withPrecision: 4)\t\(m21, withPrecision: 4) |\n\t| \(m02, withPrecision: 4)\t\(m12, withPrecision: 4)\t\(m22, withPrecision: 4) |\n"
    }
}
