//
//  IntVector3.swift
//  SwiftGLM
//
//  Created by Josef Zoller on 03.03.20.
//

import cglm

public struct IntVector3 {
    @usableFromInline internal var raw: ivec3s
    
    @usableFromInline internal init(raw: ivec3s) {
        self.raw = raw
    }
    
    
    @inlinable public init() {
        self.raw = ivec3s()
    }
    
    @inlinable public init(x: Int, y: Int, z: Int) {
        self.raw = ivec3s()
        self.raw.x = Int32(x)
        self.raw.y = Int32(y)
        self.raw.z = Int32(z)
    }
    
    @inlinable public var x: Int { Int(raw.x) }
    @inlinable public var y: Int { Int(raw.y) }
    @inlinable public var z: Int { Int(raw.z) }
}

extension IntVector3: CustomStringConvertible {
    @inlinable public var description: String {
        "Vector (int3):\n\t| \(x)\t\(y)\t\(z) |\n"
    }
}
