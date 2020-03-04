//
//  Matrix4.swift
//  SwiftGLM
//
//  Created by Josef Zoller on 03.03.20.
//

import cglm

public struct Matrix4 {
    @usableFromInline internal var raw: mat4s
    
    @usableFromInline internal init(raw: mat4s) {
        self.raw = raw
    }
    
    
    @inlinable public init() {
        self.raw = mat4s()
    }
    
    @inlinable public init(m00: Float, m01: Float, m02: Float, m03: Float, m10: Float, m11: Float, m12: Float, m13: Float, m20: Float, m21: Float, m22: Float, m23: Float, m30: Float, m31: Float, m32: Float, m33: Float) {
        self.raw = mat4s()
        self.raw.m00 = m00
        self.raw.m01 = m01
        self.raw.m02 = m02
        self.raw.m03 = m03
        self.raw.m10 = m10
        self.raw.m11 = m11
        self.raw.m12 = m12
        self.raw.m13 = m13
        self.raw.m20 = m20
        self.raw.m21 = m21
        self.raw.m22 = m22
        self.raw.m23 = m23
        self.raw.m30 = m30
        self.raw.m31 = m31
        self.raw.m32 = m32
        self.raw.m33 = m33
    }
    
    @inlinable public init(col0: Vector4, col1: Vector4, col2: Vector4, col3: Vector4) {
        self.raw = mat4s()
        self.raw.col = (col0.raw, col1.raw, col2.raw, col3.raw)
    }
    
    @inlinable public static var identity: Matrix4 {
        .init(raw: glms_mat4_identity())
    }
    
    @inlinable public static var zero: Matrix4 {
        .init(raw: glms_mat4_zero())
    }
    
    
    @inlinable public static func createTranslated(by v: Vector3) -> Matrix4 {
        .init(raw: glms_translate_make(v.raw))
    }
    
    @inlinable public static func createScaled(by v: Vector3) -> Matrix4 {
        .init(raw: glms_scale_make(v.raw))
    }
    
    @inlinable public static func createRotated(by angle: Float, axis: Vector3) -> Matrix4 {
        .init(raw: glms_rotate_make(angle, axis.raw))
    }
    
    @inlinable public mutating func createRotated(at pivot: Vector3, by angle: Float, axis: Vector3) -> Matrix4 {
        .init(raw: glms_rotate_atm(mat4s(), pivot.raw, angle, axis.raw))
    }
    
    @inlinable public mutating func createRotated(at pivot: Vector3, using q: Versors) -> Matrix4 {
        .init(raw: glms_quat_rotate_atm(q.raw, pivot.raw))
    }
    
    
    @inlinable public static func frustum(left: Float, right: Float, bottom: Float, top: Float, near: Float, far: Float) -> Matrix4 {
        .init(raw: glms_frustum(left, right, bottom, top, near, far))
    }
    
    @inlinable public static func ortho(left: Float, right: Float, bottom: Float, top: Float, near: Float, far: Float) -> Matrix4 {
        .init(raw: glms_ortho(left, right, bottom, top, near, far))
    }
    
    @inlinable public static func ortho(using box: AxisAlignedBoundingBox) -> Matrix4 {
        .init(raw: glms_ortho_aabb(box.raw))
    }
    
    @inlinable public static func ortho(using box: AxisAlignedBoundingBox, padding: Float) -> Matrix4 {
        .init(raw: glms_ortho_aabb_p(box.raw, padding))
    }
    
    @inlinable public static func ortho(using box: AxisAlignedBoundingBox, paddingNearAndFar padding: Float) -> Matrix4 {
        .init(raw: glms_ortho_aabb_pz(box.raw, padding))
    }
    
    @inlinable public static func defaultOrtho(aspectRatio: Float) -> Matrix4 {
        .init(raw: glms_ortho_default(aspectRatio))
    }
    
    @inlinable public static func defaultOrtho(aspectRatio: Float, cubeSize: Float) -> Matrix4 {
        .init(raw: glms_ortho_default_s(aspectRatio, cubeSize))
    }
    
    @inlinable public static func perspective(fovAngle: Float, aspectRatio: Float, near: Float, far: Float) -> Matrix4 {
        .init(raw: glms_perspective(fovAngle, aspectRatio, near, far))
    }
    
    @inlinable public static func defaultPerspective(aspectRatio: Float) -> Matrix4 {
        .init(raw: glms_perspective_default(aspectRatio))
    }
    
    @inlinable public static func look(from eye: Vector3, at center: Vector3, up: Vector3) -> Matrix4 {
        .init(raw: glms_lookat(eye.raw, center.raw, up.raw))
    }
    
    @inlinable public static func look(from eye: Vector3, towards direction: Vector3, up: Vector3) -> Matrix4 {
        .init(raw: glms_look(eye.raw, direction.raw, up.raw))
    }
    
    @inlinable public static func look(from eye: Vector3, towards direction: Vector3) -> Matrix4 {
        .init(raw: glms_look_anyup(eye.raw, direction.raw))
    }
    
    @inlinable public static func look(from eye: Vector3, withOrientation ori: Versors) -> Matrix4 {
        .init(raw: glms_quat_look(eye.raw, ori.raw))
    }
    
    
    @inlinable public static func inserting(_ m: Matrix3) -> Matrix4 {
        .init(raw: glms_mat4_ins3(m.raw))
    }
    
    
    @inlinable public var m00: Float { raw.m00 }
    @inlinable public var m01: Float { raw.m01 }
    @inlinable public var m02: Float { raw.m02 }
    @inlinable public var m03: Float { raw.m03 }
    @inlinable public var m10: Float { raw.m10 }
    @inlinable public var m11: Float { raw.m11 }
    @inlinable public var m12: Float { raw.m12 }
    @inlinable public var m13: Float { raw.m13 }
    @inlinable public var m20: Float { raw.m20 }
    @inlinable public var m21: Float { raw.m21 }
    @inlinable public var m22: Float { raw.m22 }
    @inlinable public var m23: Float { raw.m23 }
    @inlinable public var m30: Float { raw.m30 }
    @inlinable public var m31: Float { raw.m31 }
    @inlinable public var m32: Float { raw.m32 }
    @inlinable public var m33: Float { raw.m33 }
    
    @inlinable public var col0: Vector4 { .init(raw: raw.col.0) }
    @inlinable public var col1: Vector4 { .init(raw: raw.col.1) }
    @inlinable public var col2: Vector4 { .init(raw: raw.col.2) }
    @inlinable public var col3: Vector4 { .init(raw: raw.col.3) }
    
    
    @inlinable public var isUniformScaled: Bool { glms_uniscaled(raw) }
    
    @inlinable public var decomposedScaleVector: Vector3 {
        .init(raw: glms_decompose_scalev(raw))
    }
    
    @inlinable public var decomposedRotationMatrixAndScaleVector:
        (rotationMatrix: Matrix4, scaleVector: Vector3) {
        var r = mat4s()
        var s = vec3s()
        
        glms_decompose_rs(raw, &r, &s)
        
        return (.init(raw: r), .init(raw: s))
    }
    
    @inlinable public var decomposed:
        (translationVector: Vector4, rotationMatrix: Matrix4, scaleVector: Vector3) {
        var t = vec4s()
        var r = mat4s()
        var s = vec3s()
        
        glms_decompose(raw, &t, &r, &s)
        
        return (.init(raw: t), .init(raw: r), .init(raw: s))
    }
    
    @inlinable public var decomposedPerspective:
        (near: Float, far: Float, top: Float, bottom: Float, left: Float, right: Float) {
        var near: Float = 0
        var far: Float = 0
        var top: Float = 0
        var bottom: Float = 0
        var left: Float = 0
        var right: Float = 0
        
        glms_persp_decomp(raw, &near, &far, &top, &bottom, &left, &right)
        
        return (near, far, top, bottom, left, right)
    }
    
    @inlinable public var decomposedPerspectiveX:
        (left: Float, right: Float) {
        var left: Float = 0
        var right: Float = 0
        
        glms_persp_decomp_x(raw, &left, &right)
        
        return (left, right)
    }
    
    @inlinable public var decomposedPerspectiveY:
        (top: Float, bottom: Float) {
        var top: Float = 0
        var bottom: Float = 0
        
        glms_persp_decomp_y(raw, &top, &bottom)
        
        return (top, bottom)
    }
    
    @inlinable public var decomposedPerspectiveZ:
        (near: Float, far: Float) {
        var near: Float = 0
        var far: Float = 0
        
        glms_persp_decomp_x(raw, &near, &far)
        
        return (near, far)
    }
    
    @inlinable public var decomposedPerspectiveNear: Float {
        var near: Float = 0
        
        glms_persp_decomp_near(raw, &near)
        
        return near
    }
    
    @inlinable public var decomposedPerspectiveFar: Float {
        var far: Float = 0
        
        glms_persp_decomp_far(raw, &far)
        
        return far
    }
    
    @inlinable public var fovAngle: Float { glms_persp_fovy(raw) }
    @inlinable public var aspectRatio: Float { glms_persp_aspect(raw) }
    
    @inlinable public var eulerAngles: Vector3 {
        .init(raw: glms_euler_angles(raw))
    }
    
    @inlinable public var frustumPlanes: FrustumPlanes {
        let planes = FrustumPlanes()
        
        glms_frustum_planes(raw, planes.raw)
        
        return planes
    }
    
    @inlinable public var frustumCorners: FrustumCorners {
        let corners = FrustumCorners()
        
        glms_frustum_corners(raw, corners.raw)
        
        return corners
    }
    
    @inlinable public var unalignedCopy: Matrix4 {
        .init(raw: glms_mat4_ucopy(raw))
    }
    
    @inlinable public var copy: Matrix4 {
        .init(raw: glms_mat4_copy(raw))
    }
    
    @inlinable public var pick3: Matrix3 {
        .init(raw: glms_mat4_pick3(raw))
    }
    
    @inlinable public var pick3Transposed: Matrix3 {
        .init(raw: glms_mat4_pick3t(raw))
    }
    
    @inlinable public var trace: Float { glms_mat4_trace(raw) }
    @inlinable public var trace3: Float { glms_mat4_trace3(raw) }
    @inlinable public var quaternion: Versors { .init(raw: glms_mat4_quat(raw)) }
    @inlinable public var determinant: Float { glms_mat4_det(raw) }
    
    @inlinable public var inversed: Matrix4 {
        .init(raw: glms_mat4_inv(raw))
    }
    
    @inlinable public var fastInversed: Matrix4 {
        .init(raw: glms_mat4_inv_fast(raw))
    }
    
    @inlinable public var transposed: Matrix4 {
        .init(raw: glms_mat4_transpose(raw))
    }
    
    
    @inlinable public func perspectiveSizes(fovAngle: Float) -> Vector4 {
        .init(raw: glms_persp_sizes(raw, fovAngle))
    }
    
    
    @inlinable public mutating func translate(by v: Vector3) {
        raw = glms_translate(raw, v.raw)
    }
    
    @inlinable public func translated(by v: Vector3) -> Matrix4 {
        .init(raw: glms_translate(raw, v.raw))
    }
    
    @inlinable public mutating func translateX(by x: Float) {
        raw = glms_translate_x(raw, x)
    }
    
    @inlinable public func translatedX(by x: Float) -> Matrix4 {
        .init(raw: glms_translate(raw, Vector3(x: x, y: 0, z: 0).raw))
    }
    
    @inlinable public mutating func translateY(by y: Float) {
        raw = glms_translate_y(raw, y)
    }
    
    @inlinable public func translatedY(by y: Float) -> Matrix4 {
        .init(raw: glms_translate(raw, Vector3(x: 0, y: y, z: 0).raw))
    }
    
    @inlinable public mutating func translateZ(by z: Float) {
        raw = glms_translate_z(raw, z)
    }
    
    @inlinable public func translatedZ(by z: Float) -> Matrix4 {
        .init(raw: glms_translate(raw, Vector3(x: 0, y: 0, z: z).raw))
    }
    
    @inlinable public mutating func scale(by v: Vector3) {
        raw = glms_scale(raw, v.raw)
    }
    
    @inlinable public func scaled(by v: Vector3) -> Matrix4 {
        .init(raw: glms_scale(raw, v.raw))
    }
    
    @inlinable public mutating func scale(by s: Float) {
        raw = glms_mat4_scale(raw, s)
    }
    
    @inlinable public func scaled(by s: Float) -> Matrix4 {
        .init(col0: .init(raw: glms_vec4_scale(col0.raw, s)), col1: .init(raw: glms_vec4_scale(col1.raw, s)), col2: .init(raw: glms_vec4_scale(col2.raw, s)), col3: .init(raw: glms_vec4_scale(col3.raw, s)))
    }
    
    @inlinable public mutating func uniformScale(by s: Float) {
        raw = glms_scale_uni(raw, s)
    }
    
    @inlinable public func uniformScaled(by s: Float) -> Matrix4 {
        .init(raw: glms_scale(raw, Vector3(x: s, y: s, z: s).raw))
    }
    
    @inlinable public mutating func rotate(by angle: Float, axis: Vector3) {
        raw = glms_rotate(raw, angle, axis.raw)
    }
    
    @inlinable public mutating func rotate(using q: Versors) {
        raw = glms_quat_rotate(raw, q.raw)
    }
    
    @inlinable public mutating func rotateX(by angle: Float) {
        raw = glms_rotate_x(raw, angle)
    }
    
    @inlinable public func rotatedX(by angle: Float) -> Matrix4 {
        .init(raw: glms_rotate_x(raw, angle))
    }
    
    @inlinable public mutating func rotateY(by angle: Float) {
        raw = glms_rotate_y(raw, angle)
    }
    
    @inlinable public func rotatedY(by angle: Float) -> Matrix4 {
        .init(raw: glms_rotate_y(raw, angle))
    }
    
    @inlinable public mutating func rotateZ(by angle: Float) {
        raw = glms_rotate_z(raw, angle)
    }
    
    @inlinable public func rotatedZ(by angle: Float) -> Matrix4 {
        .init(raw: glms_rotate_z(raw, angle))
    }
    
    @inlinable public mutating func rotate(at pivot: Vector3, by angle: Float, axis: Vector3) {
        raw = glms_rotate_at(raw, pivot.raw, angle, axis.raw)
    }
    
    @inlinable public mutating func rotate(at pivot: Vector3, using q: Versors) {
        raw = glms_quat_rotate_at(raw, q.raw, pivot.raw)
    }
    
    
    @inlinable public mutating func movePerspectiveFar(by delta: Float) {
        glms_persp_move_far(raw, delta)
    }
    
    @inlinable public mutating func resizePerspective(by aspectRatio: Float) {
        glms_perspective_resize(raw, aspectRatio)
    }
    
    
    @inlinable public mutating func inverse() {
        raw = glms_mat4_inv(raw)
    }
    
    @inlinable public mutating func inverseFast() {
        raw = glms_mat4_inv_fast(raw)
    }
    
    @inlinable public mutating func transpose() {
        raw = glms_mat4_transpose(raw)
    }
    
    @inlinable public mutating func swap(columnWithNumber col0: Int, with col1: Int) {
        raw = glms_mat4_swap_col(raw, Int32(col0), Int32(col1))
    }
    
    @inlinable public mutating func swap(rowWithNumber row0: Int, with row1: Int) {
        raw = glms_mat4_swap_row(raw, Int32(row0), Int32(row1))
    }
    
    
    @inlinable public func rmc(row: Vector4, col: Vector4) -> Float {
        glms_mat4_rmc(row.raw, raw, col.raw)
    }
    
    
    @inlinable public static func *(lhs: Matrix4, rhs: Matrix4) -> Matrix4 {
        .init(raw: glms_mat4_mul(lhs.raw, rhs.raw))
    }
    
    @inlinable public static func *(lhs: Matrix4, rhs: Vector4) -> Vector4 {
        .init(raw: glms_mat4_mulv(lhs.raw, rhs.raw))
    }
    
    @inlinable public static func *(lhs: Matrix4, rhs: (Vector3, Float)) -> Vector3 {
        .init(raw: glms_mat4_mulv3(lhs.raw, rhs.0.raw, rhs.1))
    }
}

extension Matrix4: CustomStringConvertible {
    @inlinable public var description: String {
        "Matrix (float4x4):\n\t| \(m00, withPrecision: 4)\t\(m10, withPrecision: 4)\t\(m20, withPrecision: 4)\t\(m30, withPrecision: 4) |\n\t| \(m01, withPrecision: 4)\t\(m11, withPrecision: 4)\t\(m21, withPrecision: 4)\t\(m31, withPrecision: 4) |\n\t| \(m02, withPrecision: 4)\t\(m12, withPrecision: 4)\t\(m22, withPrecision: 4)\t\(m32, withPrecision: 4) |\n\t| \(m03, withPrecision: 4)\t\(m13, withPrecision: 4)\t\(m23, withPrecision: 4)\t\(m33, withPrecision: 4) |\n"
    }
}
