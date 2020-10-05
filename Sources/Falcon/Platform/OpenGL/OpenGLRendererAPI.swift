//
//  OpenGLRendererAPI.swift
//  Falcon
//
//  Created by Josef Zoller on 04.10.20.
//

#if canImport(glad)

import glad
import SGLMath

class OpenGLRendererAPI: RendererAPI {
    func set(clearColor color: vec4) {
        glad_glClearColor(color.r, color.g, color.b, color.a)
    }

    func clear() {
        glad_glClear(GLenum(GL_COLOR_BUFFER_BIT))
    }

    func drawIndexed(vertexArray: VertexArray) {
        glad_glDrawElements(GLenum(GL_TRIANGLES), GLsizei(vertexArray.indexBuffer!.count), GLenum(GL_UNSIGNED_INT), nil)
    }
}

#endif
