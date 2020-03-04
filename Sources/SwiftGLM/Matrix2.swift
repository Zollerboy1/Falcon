//
//  Matrix2.swift
//  SwiftGLM
//
//  Created by Josef Zoller on 03.03.20.
//

import cglm

public struct Matrix2 {
    @usableFromInline internal var raw: mat2s
    
    @usableFromInline internal init(raw: mat2s) {
        self.raw = raw
    }
    
    
    @inlinable public init() {
        self.raw = mat2s()
    }
    
    @inlinable public init(m00: Float, m01: Float, m10: Float, m11: Float) {
        self.raw = mat2s()
        self.raw.m00 = m00
        self.raw.m01 = m01
        self.raw.m10 = m10
        self.raw.m11 = m11
    }
    
    @inlinable public init(col0: Vector2, col1: Vector2) {
        self.raw = mat2s()
        self.raw.col = (col0.raw, col1.raw)
    }
    
    
    @inlinable public static var identity: Matrix2 {
        .init(raw: glms_mat2_identity())
    }
    
    @inlinable public static var zero: Matrix2 {
        .init(raw: glms_mat2_zero())
    }
    
    
    @inlinable public var m00: Float { raw.m00 }
    @inlinable public var m01: Float { raw.m01 }
    @inlinable public var m10: Float { raw.m10 }
    @inlinable public var m11: Float { raw.m11 }
    
    @inlinable public var col0: Vector2 { .init(raw: raw.col.0) }
    @inlinable public var col1: Vector2 { .init(raw: raw.col.1) }
    
    @inlinable public var trace: Float { glms_mat2_trace(raw) }
    @inlinable public var determinant: Float { glms_mat2_det(raw) }
    
    @inlinable public var inversed: Matrix2 {
        .init(raw: glms_mat2_inv(raw))
    }
    
    @inlinable public var transposed: Matrix2 {
        .init(raw: glms_mat2_transpose(raw))
    }
    
    
    @inlinable public mutating func transpose() {
        raw = glms_mat2_transpose(raw)
    }
    
    @inlinable public mutating func scale(by s: Float) {
        raw = glms_mat2_scale(raw, s)
    }
    
    @inlinable public mutating func inverse() {
        raw = glms_mat2_inv(raw)
    }
    
    @inlinable public mutating func swap(columnWithNumber col0: Int, with col1: Int) {
        raw = glms_mat2_swap_col(raw, Int32(col0), Int32(col1))
    }
    
    @inlinable public mutating func swap(rowWithNumber row0: Int, with row1: Int) {
        raw = glms_mat2_swap_row(raw, Int32(row0), Int32(row1))
    }
    
    
    @inlinable public func rmc(row: Vector2, col: Vector2) -> Float {
        glms_mat2_rmc(row.raw, raw, col.raw)
    }
    
    
    @inlinable public static func *(lhs: Matrix2, rhs: Matrix2) -> Matrix2 {
        .init(raw: glms_mat2_mul(lhs.raw, rhs.raw))
    }
    
    @inlinable public static func *(lhs: Matrix2, rhs: Vector2) -> Vector2 {
        .init(raw: glms_mat2_mulv(lhs.raw, rhs.raw))
    }
}
