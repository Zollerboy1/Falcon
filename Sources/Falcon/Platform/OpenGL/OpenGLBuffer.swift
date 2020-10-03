//
//  OpenGLBuffer.swift
//  Falcon
//
//  Created by Josef Zoller on 03.10.20.
//

#if canImport(glad)

import glad

// MARK: VertexBuffer

class OpenGLVertexBuffer: VertexBuffer {
    private let id: UInt32

    let layout: BufferLayout

    init(withVertices vertices: [Float], layout: BufferLayout) {
        var id: UInt32 = 0
        glad_glGenBuffers(1, &id)
        glad_glBindBuffer(GLenum(GL_ARRAY_BUFFER), id)

        vertices.withUnsafeBytes { buffer in
            glad_glBufferData(GLenum(GL_ARRAY_BUFFER), vertices.count * MemoryLayout<Float>.size, buffer.baseAddress, GLenum(GL_STATIC_DRAW))
        }

        self.id = id
        self.layout = layout

//        withBound {
//            vertices.withUnsafeBytes { buffer in
//                glad_glBufferData(GLenum(GL_ARRAY_BUFFER), vertices.count * MemoryLayout<Float>.size, buffer.baseAddress, GLenum(GL_STATIC_DRAW))
//            }
//        }
    }

    init(withVertices vertices: [Float], @BufferLayout.Builder buildLayoutElements: BufferLayout.BuildFunction) {
        var id: UInt32 = 0
        glad_glGenBuffers(1, &id)
        glad_glBindBuffer(GLenum(GL_ARRAY_BUFFER), id)

        vertices.withUnsafeBytes { buffer in
            glad_glBufferData(GLenum(GL_ARRAY_BUFFER), vertices.count * MemoryLayout<Float>.size, buffer.baseAddress, GLenum(GL_STATIC_DRAW))
        }

        self.id = id
        self.layout = BufferLayout(buildElements: buildLayoutElements)

//        withBound {
//            vertices.withUnsafeBytes { buffer in
//                glad_glBufferData(GLenum(GL_ARRAY_BUFFER), vertices.count * MemoryLayout<Float>.size, buffer.baseAddress, GLenum(GL_STATIC_DRAW))
//            }
//        }
    }

    deinit {
        var id = self.id
        glad_glDeleteBuffers(1, &id)
    }

//    func withBound<R>(_ body: () -> R) -> R {
//        glad_glBindBuffer(GLenum(GL_ARRAY_BUFFER), id)
//
//        let returnValue = body()
//
//        glad_glBindBuffer(GLenum(GL_ARRAY_BUFFER), 0)
//
//        return returnValue
//    }
//
//    func bindOnce() {
//        glad_glBindBuffer(GLenum(GL_ARRAY_BUFFER), id)
//        glad_glBindBuffer(GLenum(GL_ARRAY_BUFFER), 0)
//    }

    func bind() {
        glad_glBindBuffer(GLenum(GL_ARRAY_BUFFER), id)
    }

    func unbind() {
        glad_glBindBuffer(GLenum(GL_ARRAY_BUFFER), 0)
    }
}

// MARK: - IndexBuffer

class OpenGLIndexBuffer: IndexBuffer {
    private let id: UInt32

    let count: Int

    init(withIndices indices: [UInt32]) {
        var id: UInt32 = 0
        glad_glGenBuffers(1, &id)
        glad_glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), id)

        indices.withUnsafeBytes { buffer in
            glad_glBufferData(GLenum(GL_ELEMENT_ARRAY_BUFFER), indices.count * MemoryLayout<Float>.size, buffer.baseAddress, GLenum(GL_STATIC_DRAW))
        }

        self.id = id
        self.count = indices.count

//        withBound {
//            indices.withUnsafeBytes { buffer in
//                glad_glBufferData(GLenum(GL_ELEMENT_ARRAY_BUFFER), indices.count * MemoryLayout<Float>.size, buffer.baseAddress, GLenum(GL_STATIC_DRAW))
//            }
//        }
    }

    deinit {
        var id = self.id
        glad_glDeleteBuffers(1, &id)
    }

//    func withBound<R>(_ body: () -> R) -> R {
//        glad_glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), id)
//
//        let returnValue = body()
//
//        glad_glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), 0)
//
//        return returnValue
//    }
//
//    func bindOnce() {
//        glad_glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), id)
//        glad_glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), 0)
//    }

    func bind() {
        glad_glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), id)
    }

    func unbind() {
        glad_glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), 0)
    }
}

#endif
