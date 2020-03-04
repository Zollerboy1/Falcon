//
//  Frustum.swift
//  SwiftGLM
//
//  Created by Josef Zoller on 03.03.20.
//

import cglm

public struct PlaneCorners {
    @usableFromInline internal let raw: UnsafeMutablePointer<vec4s>
    
    @usableFromInline internal init(raw: UnsafeMutablePointer<vec4s>) {
        self.raw = raw
    }
    
    @inlinable public init() {
        self.raw = UnsafeMutablePointer<vec4s>.allocate(capacity: 4)
        self.raw.initialize(repeating: vec4s(), count: 4)
    }
    
    @inlinable public init(vec0: Vector4, vec1: Vector4, vec2: Vector4, vec3: Vector4) {
        self.raw = UnsafeMutablePointer<vec4s>.allocate(capacity: 4)
        self.raw.initialize(repeating: vec4s(), count: 4)
        
        self.raw[0] = vec0.raw
        self.raw[1] = vec1.raw
        self.raw[2] = vec2.raw
        self.raw[3] = vec3.raw
    }
    
    @inlinable public var vec0: Vector4 { .init(raw: raw[0]) }
    @inlinable public var vec1: Vector4 { .init(raw: raw[1]) }
    @inlinable public var vec2: Vector4 { .init(raw: raw[2]) }
    @inlinable public var vec3: Vector4 { .init(raw: raw[3]) }
}

public struct FrustumPlanes {
    @usableFromInline internal let raw: UnsafeMutablePointer<vec4s>
    
    @usableFromInline internal init(raw: UnsafeMutablePointer<vec4s>) {
        self.raw = raw
    }
    
    @inlinable public init() {
        self.raw = UnsafeMutablePointer<vec4s>.allocate(capacity: 6)
        self.raw.initialize(repeating: vec4s(), count: 6)
    }
    
    @inlinable public init(vec0: Vector4, vec1: Vector4, vec2: Vector4, vec3: Vector4, vec4: Vector4, vec5: Vector4) {
        self.raw = UnsafeMutablePointer<vec4s>.allocate(capacity: 6)
        self.raw.initialize(repeating: vec4s(), count: 6)
        
        self.raw[0] = vec0.raw
        self.raw[1] = vec1.raw
        self.raw[2] = vec2.raw
        self.raw[3] = vec3.raw
        self.raw[4] = vec4.raw
        self.raw[5] = vec5.raw
    }
    
    @inlinable public var vec0: Vector4 { .init(raw: raw[0]) }
    @inlinable public var vec1: Vector4 { .init(raw: raw[1]) }
    @inlinable public var vec2: Vector4 { .init(raw: raw[2]) }
    @inlinable public var vec3: Vector4 { .init(raw: raw[3]) }
    @inlinable public var vec4: Vector4 { .init(raw: raw[4]) }
    @inlinable public var vec5: Vector4 { .init(raw: raw[5]) }
}

public struct FrustumCorners {
    @usableFromInline internal let raw: UnsafeMutablePointer<vec4s>
    
    @usableFromInline internal init(raw: UnsafeMutablePointer<vec4s>) {
        self.raw = raw
    }
    
    @inlinable public init() {
        self.raw = UnsafeMutablePointer<vec4s>.allocate(capacity: 8)
        self.raw.initialize(repeating: vec4s(), count: 8)
    }
    
    @inlinable public init(vec0: Vector4, vec1: Vector4, vec2: Vector4, vec3: Vector4, vec4: Vector4, vec5: Vector4, vec6: Vector4, vec7: Vector4) {
        self.raw = UnsafeMutablePointer<vec4s>.allocate(capacity: 8)
        self.raw.initialize(repeating: vec4s(), count: 8)
        
        self.raw[0] = vec0.raw
        self.raw[1] = vec1.raw
        self.raw[2] = vec2.raw
        self.raw[3] = vec3.raw
        self.raw[4] = vec4.raw
        self.raw[5] = vec5.raw
        self.raw[6] = vec6.raw
        self.raw[7] = vec7.raw
    }
    
    @inlinable public var vec0: Vector4 { .init(raw: raw[0]) }
    @inlinable public var vec1: Vector4 { .init(raw: raw[1]) }
    @inlinable public var vec2: Vector4 { .init(raw: raw[2]) }
    @inlinable public var vec3: Vector4 { .init(raw: raw[3]) }
    @inlinable public var vec4: Vector4 { .init(raw: raw[4]) }
    @inlinable public var vec5: Vector4 { .init(raw: raw[5]) }
    @inlinable public var vec6: Vector4 { .init(raw: raw[6]) }
    @inlinable public var vec7: Vector4 { .init(raw: raw[7]) }
    
    @inlinable public var center: Vector4 {
        .init(raw: glms_frustum_center(raw))
    }
    
    
    @inlinable public func box(relativeTo m: Matrix4) -> AxisAlignedBoundingBox {
        let box = AxisAlignedBoundingBox()
        
        glms_frustum_box(raw, m.raw, box.raw)
        
        return box
    }
    
    @inlinable public func corners(atSplit split: Float, far: Float) -> PlaneCorners {
        let planeCorners = PlaneCorners()
        
        glms_frustum_corners_at(raw, split, far, planeCorners.raw)
        
        return planeCorners
    }
}
