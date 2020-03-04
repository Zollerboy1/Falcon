//
//  AxisAlignedBoundingBox.swift
//  SwiftGLM
//
//  Created by Josef Zoller on 03.03.20.
//

import cglm

public struct AxisAlignedBoundingBox {
    @usableFromInline internal let raw: UnsafeMutablePointer<vec3s>
    
    @usableFromInline internal init(raw: UnsafeMutablePointer<vec3s>) {
        self.raw = raw
    }
    
    @inlinable public init() {
        self.raw = UnsafeMutablePointer<vec3s>.allocate(capacity: 2)
        self.raw.initialize(repeating: vec3s(), count: 2)
    }
    
    @inlinable public init(vec0: Vector3, vec1: Vector3) {
        self.raw = UnsafeMutablePointer<vec3s>.allocate(capacity: 2)
        self.raw.initialize(repeating: vec3s(), count: 2)
        
        self.raw[0] = vec0.raw
        self.raw[1] = vec1.raw
    }
    
    @inlinable public var vec0: Vector3 { .init(raw: raw[0]) }
    @inlinable public var vec1: Vector3 { .init(raw: raw[1]) }
    
    @inlinable public var isValid: Bool { glms_aabb_isvalid(raw) }
    
    @inlinable public var size: Float { glms_aabb_size(raw) }
    @inlinable public var radius: Float { glms_aabb_radius(raw) }
    @inlinable public var center: Vector3 { .init(raw: glms_aabb_center(raw)) }
    
    
    @inlinable public mutating func transform(applying m: Matrix4) {
        let dest = UnsafeMutablePointer<vec3s>.allocate(capacity: 2)
        dest.initialize(repeating: vec3s(), count: 2)
        
        glms_aabb_transform(raw, m.raw, dest)
        
        self.raw[0] = dest[0]
        self.raw[1] = dest[1]
        
        dest.deinitialize(count: 2)
        dest.deallocate()
    }
    
    @inlinable public func transformed(applying m: Matrix4) -> AxisAlignedBoundingBox {
        let dest = UnsafeMutablePointer<vec3s>.allocate(capacity: 2)
        dest.initialize(repeating: vec3s(), count: 2)
        
        glms_aabb_transform(raw, m.raw, dest)
        
        return .init(raw: dest)
    }
    
    @inlinable public mutating func merge(with other: AxisAlignedBoundingBox) {
        let dest = UnsafeMutablePointer<vec3s>.allocate(capacity: 2)
        dest.initialize(repeating: vec3s(), count: 2)
        
        glms_aabb_merge(raw, other.raw, dest)
        
        self.raw[0] = dest[0]
        self.raw[1] = dest[1]
        
        dest.deinitialize(count: 2)
        dest.deallocate()
    }
    
    @inlinable public func merged(with other: AxisAlignedBoundingBox) -> AxisAlignedBoundingBox {
        let dest = UnsafeMutablePointer<vec3s>.allocate(capacity: 2)
        dest.initialize(repeating: vec3s(), count: 2)
        
        glms_aabb_merge(raw, other.raw, dest)
        
        return .init(raw: dest)
    }
    
    @inlinable public mutating func crop(with other: AxisAlignedBoundingBox) {
        let dest = UnsafeMutablePointer<vec3s>.allocate(capacity: 2)
        dest.initialize(repeating: vec3s(), count: 2)
        
        glms_aabb_crop(raw, other.raw, dest)
        
        self.raw[0] = dest[0]
        self.raw[1] = dest[1]
        
        dest.deinitialize(count: 2)
        dest.deallocate()
    }
    
    @inlinable public func cropped(with other: AxisAlignedBoundingBox) -> AxisAlignedBoundingBox {
        let dest = UnsafeMutablePointer<vec3s>.allocate(capacity: 2)
        dest.initialize(repeating: vec3s(), count: 2)
        
        glms_aabb_crop(raw, other.raw, dest)
        
        return .init(raw: dest)
    }
    
    @inlinable public mutating func crop(with other: AxisAlignedBoundingBox, until: AxisAlignedBoundingBox) {
        let dest = UnsafeMutablePointer<vec3s>.allocate(capacity: 2)
        dest.initialize(repeating: vec3s(), count: 2)
        
        glms_aabb_crop_until(raw, other.raw, until.raw, dest)
        
        self.raw[0] = dest[0]
        self.raw[1] = dest[1]
        
        dest.deinitialize(count: 2)
        dest.deallocate()
    }
    
    @inlinable public func cropped(with other: AxisAlignedBoundingBox, until: AxisAlignedBoundingBox) -> AxisAlignedBoundingBox {
        let dest = UnsafeMutablePointer<vec3s>.allocate(capacity: 2)
        dest.initialize(repeating: vec3s(), count: 2)
        
        glms_aabb_crop_until(raw, other.raw, until.raw, dest)
        
        return .init(raw: dest)
    }
    
    @inlinable public func intersectsWith(frustumPlanes planes: FrustumPlanes) -> Bool {
        return glms_aabb_frustum(raw, planes.raw)
    }
    
    @inlinable public mutating func invalidate() {
        glms_aabb_invalidate(raw)
    }
    
    
    @inlinable public func intersects(with other: AxisAlignedBoundingBox) -> Bool {
        glms_aabb_aabb(raw, other.raw)
    }
    
    @inlinable public func intersects(withSphere s: Vector4) -> Bool {
        glms_aabb_sphere(raw, s.raw)
    }
    
    @inlinable public func contains(_ other: AxisAlignedBoundingBox) -> Bool {
        glms_aabb_contains(raw, other.raw)
    }
    
    @inlinable public func contains(point: Vector3) -> Bool {
        glms_aabb_point(raw, point.raw)
    }
}

extension AxisAlignedBoundingBox: CustomStringConvertible {
    @inlinable public var description: String {
        "AABB (float):\n\t| \(vec0.x, withPrecision: 4)\t\(vec0.y, withPrecision: 4)\t\(vec0.z, withPrecision: 4) |\n\t| \(vec1.x, withPrecision: 4)\t\(vec1.y, withPrecision: 4)\t\(vec1.z, withPrecision: 4) |\n"
    }
}

