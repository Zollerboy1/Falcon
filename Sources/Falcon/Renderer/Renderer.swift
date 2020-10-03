//
//  Renderer.swift
//  Falcon
//
//  Created by Josef Zoller on 03.10.20.
//

public enum Renderer {
    public enum API {
    #if canImport(glad)
        case openGL
    #endif

        case none
    }

    #if canImport(glad)
    public static var currentAPI = API.openGL
    #else
    public static var currentAPI = API.none
    #endif


}


// MARK: - Factory methods

extension Renderer {
    public static func createVertexBuffer(withVertices vertices: [Float], layout: BufferLayout) -> VertexBuffer {
        switch currentAPI {
        #if canImport(glad)
        case .openGL:
            return OpenGLVertexBuffer(withVertices: vertices, layout: layout)
        #endif
        
        case .none:
            Log.coreFatal("Have no renderer API!")
        }
    }

    public static func createVertexBuffer(withVertices vertices: [Float], @BufferLayout.Builder buildLayoutElements: BufferLayout.BuildFunction) -> VertexBuffer {
        switch currentAPI {
        #if canImport(glad)
        case .openGL:
            return OpenGLVertexBuffer(withVertices: vertices, buildLayoutElements: buildLayoutElements)
        #endif

        case .none:
            Log.coreFatal("Have no renderer API!")
        }
    }

    public static func createIndexBuffer(withIndices indices: [UInt32]) -> IndexBuffer {
        switch currentAPI {
        #if canImport(glad)
        case .openGL:
            return OpenGLIndexBuffer(withIndices: indices)
        #endif

        case .none:
            Log.coreFatal("Have no renderer API!")
        }
    }

    public static func createVertexArray() -> VertexArray {
        switch currentAPI {
        #if canImport(glad)
        case .openGL:
            return OpenGLVertexArray()
        #endif

        case .none:
            Log.coreFatal("Have no renderer API!")
        }
    }
}
