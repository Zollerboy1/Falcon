//
//  Renderer.swift
//  Falcon
//
//  Created by Josef Zoller on 04.10.20.
//

import SGLMath

public enum Renderer {
    public enum UnderlyingAPI {
    #if canImport(glad)
        case openGL
    #endif

        case none


        #if canImport(glad)
        public static let current = Self.openGL
        #else
        public static let current = Self.none
        #endif
    }


    private struct SceneData {
        let viewProjectionMatrix: mat4
    }

    private static var sceneData: SceneData?


    public static func scene<R>(withCamera camera: Camera, body: () throws -> R) rethrows -> R {
        sceneData = SceneData(viewProjectionMatrix: camera.viewProjectionMatrix)

        let result = try body()

        sceneData = nil

        return result
    }

    public static func submit(vertexArray: VertexArray, withShader shader: Shader) {
        guard let sceneData = Renderer.sceneData else {
            Log.coreFatal("Can only call Renderer.submit() inside a scene!")
        }

        shader.bind()
        shader.uploadUniform(matrix: sceneData.viewProjectionMatrix, withName: "u_ViewProjection")

        vertexArray.withBound {
            RenderCommand.drawIndexed(vertexArray: vertexArray)
        }
    }
}



// MARK: - Factory methods

extension Renderer {
    public static func createVertexBuffer(withVertices vertices: [Float], layout: BufferLayout) -> VertexBuffer {
        switch UnderlyingAPI.current {
        #if canImport(glad)
        case .openGL:
            return OpenGLVertexBuffer(withVertices: vertices, layout: layout)
        #endif

        case .none:
            Log.coreFatal("Have no graphics API!")
        }
    }

    public static func createVertexBuffer(withVertices vertices: [Float], @BufferLayout.Builder buildLayoutElements: BufferLayout.BuildFunction) -> VertexBuffer {
        switch UnderlyingAPI.current {
        #if canImport(glad)
        case .openGL:
            return OpenGLVertexBuffer(withVertices: vertices, buildLayoutElements: buildLayoutElements)
        #endif

        case .none:
            Log.coreFatal("Have no graphics API!")
        }
    }

    public static func createIndexBuffer(withIndices indices: [UInt32]) -> IndexBuffer {
        switch UnderlyingAPI.current {
        #if canImport(glad)
        case .openGL:
            return OpenGLIndexBuffer(withIndices: indices)
        #endif

        case .none:
            Log.coreFatal("Have no graphics API!")
        }
    }

    public static func createVertexArray() -> VertexArray {
        switch UnderlyingAPI.current {
        #if canImport(glad)
        case .openGL:
            return OpenGLVertexArray()
        #endif

        case .none:
            Log.coreFatal("Have no graphics API!")
        }
    }
}
