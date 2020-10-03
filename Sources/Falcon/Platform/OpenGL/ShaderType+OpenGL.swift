//
//  ShaderType+OpenGL.swift
//  Falcon
//
//  Created by Josef Zoller on 03.10.20.
//

#if canImport(glad)

import glad

extension ShaderType {
    var openGLComponentCount: Int {
        switch self {
        case .float:    return 1
        case .float2:   return 2
        case .float3:   return 3
        case .float4:   return 4
        case .float3x3: return 3 * 3
        case .float4x4: return 4 * 4
        case .int:      return 1
        case .int2:     return 2
        case .int3:     return 3
        case .int4:     return 4
        case .bool:     return 1
        }
    }

    var openGLType: GLenum {
        switch self {
        case .float,
             .float2,
             .float3,
             .float4,
             .float3x3,
             .float4x4: return GLenum(GL_FLOAT)
        case .int,
             .int2,
             .int3,
             .int4: return GLenum(GL_INT)
        case .bool: return GLenum(GL_BOOL)
        }
    }
}

#endif
