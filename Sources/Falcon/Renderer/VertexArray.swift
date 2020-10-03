//
//  VertexArray.swift
//  Falcon
//
//  Created by Josef Zoller on 03.10.20.
//

public protocol VertexArray: AnyObject {
    var vertexBuffers: [VertexBuffer] { get }
    var indexBuffer: IndexBuffer? { get set }

    func withBound<R>(_ body: () -> R) -> R
    func bindOnce()

    func add(vertexBuffer: VertexBuffer)
}
