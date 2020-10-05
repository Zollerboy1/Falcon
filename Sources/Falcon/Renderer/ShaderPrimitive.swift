//
//  ShaderPrimitive.swift
//  Falcon
//
//  Created by Josef Zoller on 03.10.20.
//

public enum ShaderType {
    case float, float2, float3, float4
    case float3x3, float4x4
    case int, int2, int3, int4
    case bool

    private static let floatSize = Int(MemoryLayout<Float>.size)
    private static let intSize = Int(MemoryLayout<Int32>.size)
    private static let boolSize = Int(MemoryLayout<Bool>.size)

    var size: Int {
        switch self {
        case .float: return ShaderType.floatSize
        case .float2: return ShaderType.floatSize * 2
        case .float3: return ShaderType.floatSize * 3
        case .float4: return ShaderType.floatSize * 4
        case .float3x3: return ShaderType.floatSize * 3 * 3
        case .float4x4: return ShaderType.floatSize * 4 * 4
        case .int: return ShaderType.intSize
        case .int2: return ShaderType.intSize * 2
        case .int3: return ShaderType.intSize * 3
        case .int4: return ShaderType.intSize * 4
        case .bool: return ShaderType.boolSize
        }
    }

    var componentCount: Int {
        switch Renderer.UnderlyingAPI.current {
        #if canImport(glad)
        case .openGL:
            return openGLComponentCount
        #endif

        case .none:
            Log.coreFatal("Have no graphics API!")
        }
    }
}


public protocol ShaderPrimitive {
    var type: ShaderType { get }
    var name: String { get }
    var isNormalized: Bool {get }
}

public struct ShaderFloat: ShaderPrimitive {
    public let type = ShaderType.float
    public let name: String
    public let isNormalized: Bool

    public init(withName name: String, isNormalized: Bool = false) {
        self.name = name
        self.isNormalized = isNormalized
    }
}

public struct ShaderFloat2: ShaderPrimitive {
    public let type = ShaderType.float2
    public let name: String
    public let isNormalized: Bool

    public init(withName name: String, isNormalized: Bool = false) {
        self.name = name
        self.isNormalized = isNormalized
    }
}

public struct ShaderFloat3: ShaderPrimitive {
    public let type = ShaderType.float3
    public let name: String
    public let isNormalized: Bool

    public init(withName name: String, isNormalized: Bool = false) {
        self.name = name
        self.isNormalized = isNormalized
    }
}

public struct ShaderFloat4: ShaderPrimitive {
    public let type = ShaderType.float4
    public let name: String
    public let isNormalized: Bool

    public init(withName name: String, isNormalized: Bool = false) {
        self.name = name
        self.isNormalized = isNormalized
    }
}

public struct ShaderFloat3x3: ShaderPrimitive {
    public let type = ShaderType.float3x3
    public let name: String
    public let isNormalized: Bool

    public init(withName name: String, isNormalized: Bool = false) {
        self.name = name
        self.isNormalized = isNormalized
    }
}

public struct ShaderFloat4x4: ShaderPrimitive {
    public let type = ShaderType.float4x4
    public let name: String
    public let isNormalized: Bool
}

public struct ShaderInt: ShaderPrimitive {
    public let type = ShaderType.int
    public let name: String
    public let isNormalized: Bool

    public init(withName name: String, isNormalized: Bool = false) {
        self.name = name
        self.isNormalized = isNormalized
    }
}

public struct ShaderInt2: ShaderPrimitive {
    public let type = ShaderType.int2
    public let name: String
    public let isNormalized: Bool

    public init(withName name: String, isNormalized: Bool = false) {
        self.name = name
        self.isNormalized = isNormalized
    }
}

public struct ShaderInt3: ShaderPrimitive {
    public let type = ShaderType.int3
    public let name: String
    public let isNormalized: Bool

    public init(withName name: String, isNormalized: Bool = false) {
        self.name = name
        self.isNormalized = isNormalized
    }
}

public struct ShaderInt4: ShaderPrimitive {
    public let type = ShaderType.int4
    public let name: String
    public let isNormalized: Bool

    public init(withName name: String, isNormalized: Bool = false) {
        self.name = name
        self.isNormalized = isNormalized
    }
}

public struct ShaderBool: ShaderPrimitive {
    public let type = ShaderType.bool
    public let name: String
    public let isNormalized: Bool

    public init(withName name: String, isNormalized: Bool = false) {
        self.name = name
        self.isNormalized = isNormalized
    }
}
