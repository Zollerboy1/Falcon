//
//  RendererAPI.swift
//  Falcon
//
//  Created by Josef Zoller on 03.10.20.
//

import SGLMath

@usableFromInline
protocol RendererAPI: AnyObject {
    func set(clearColor color: vec4)
    func clear()

    func drawIndexed(vertexArray: VertexArray)
}
