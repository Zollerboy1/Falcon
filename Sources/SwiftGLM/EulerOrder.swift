//
//  EulerOrder.swift
//  SwiftGLM
//
//  Created by Josef Zoller on 03.03.20.
//

import cglm

public enum EulerOrder {
    case xyz, xzy, yxz, yzx, zxy, zyx
    
    @inlinable public var raw: glm_euler_seq {
        switch self {
        case .xyz: return GLM_EULER_XYZ
        case .xzy: return GLM_EULER_XZY
        case .yxz: return GLM_EULER_YXZ
        case .yzx: return GLM_EULER_YZX
        case .zxy: return GLM_EULER_ZXY
        case .zyx: return GLM_EULER_ZYX
        }
    }
    
    @inlinable public init(raw: glm_euler_seq) {
        switch raw {
        case GLM_EULER_XYZ: self = .xyz
        case GLM_EULER_XZY: self = .xzy
        case GLM_EULER_YXZ: self = .yxz
        case GLM_EULER_YZX: self = .yzx
        case GLM_EULER_ZXY: self = .zxy
        case GLM_EULER_ZYX: self = .zyx
        default: preconditionFailure("Tried to initialize EulerOrder with nonexisting glm_euler_seq value.")
        }
    }
}
