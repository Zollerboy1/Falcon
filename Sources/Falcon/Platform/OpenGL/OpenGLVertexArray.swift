//
//  OpenGLVertexArray.swift
//  Falcon
//
//  Created by Josef Zoller on 03.10.20.
//

#if canImport(glad)

import glad

class OpenGLVertexArray: VertexArray {
    private let id: UInt32

    private(set) var vertexBuffers = [VertexBuffer]()

    var indexBuffer: IndexBuffer? {
        willSet {
            if let indexBuffer = newValue {
                withBound {
                    indexBuffer.bind()
                }
            }
        }
    }

    init() {
        var id: UInt32 = 0
        glad_glGenVertexArrays(1, &id)

        self.id = id
    }

    deinit {
        var id = self.id
        glad_glDeleteVertexArrays(1, &id)
    }

    func withBound<R>(_ body: () throws -> R) rethrows -> R {
        glad_glBindVertexArray(id)

        let result = try body()

        glad_glBindVertexArray(0)

        return result
    }

    func bindOnce() {
        glad_glBindVertexArray(id)
        glad_glBindVertexArray(0)
    }

    func add(vertexBuffer: VertexBuffer) {
        withBound {
            vertexBuffer.bind()

            for (i, element) in vertexBuffer.layout.elements.enumerated() {
                glad_glEnableVertexAttribArray(GLuint(i))
                glad_glVertexAttribPointer(GLuint(i),
                    GLint(element.type.componentCount),
                    element.type.openGLType,
                    GLboolean(element.isNormalized ? GL_TRUE : GL_FALSE),
                    GLint(vertexBuffer.layout.stride),
                    UnsafeRawPointer(bitPattern: element.offset))
            }
        }

        self.vertexBuffers.append(vertexBuffer)
    }
}

#endif
