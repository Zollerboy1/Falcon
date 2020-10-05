//
//  RenderCommand.swift
//  Falcon
//
//  Created by Josef Zoller on 04.10.20.
//

import SGLMath

public enum RenderCommand {
    @usableFromInline
    static let rendererAPI: RendererAPI = {
        switch Renderer.UnderlyingAPI.current {
        #if canImport(glad)
        case .openGL:
            return OpenGLRendererAPI()
        #endif

        case .none:
            Log.coreFatal("Have no graphics API!")
        }
    }()


    @inlinable
    public static func set(clearColor color: vec4) {
        rendererAPI.set(clearColor: color)
    }

    @inlinable
    public static func clear() {
        rendererAPI.clear()
    }

    @inlinable
    public static func drawIndexed(vertexArray: VertexArray) {
        rendererAPI.drawIndexed(vertexArray: vertexArray)
    }
}
