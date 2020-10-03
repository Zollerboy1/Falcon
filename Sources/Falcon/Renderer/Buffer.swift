//
//  Buffer.swift
//  Falcon
//
//  Created by Josef Zoller on 03.10.20.
//

// MARK: VertexBuffer

public protocol VertexBuffer: AnyObject {
    var layout: BufferLayout { get }

    //func withBound<R>(_ body: () -> R) -> R
    //func bindOnce()

    func bind()
    func unbind()
}

// MARK: - IndexBuffer

public protocol IndexBuffer: AnyObject {
    var count: Int { get }

    //func withBound<R>(_ body: () -> R) -> R
    //func bindOnce()

    func bind()
    func unbind()
}
