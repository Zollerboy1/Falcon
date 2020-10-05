//
//  OrthographicCamera.swift
//  Falcon
//
//  Created by Josef Zoller on 04.10.20.
//

import SGLMath

public protocol Camera {
    var projectionMatrix: mat4 { get }
    var viewMatrix: mat4 { get }
    var viewProjectionMatrix: mat4 { get }

    var position: vec3 { get set }
}

public class OrthographicCamera: Camera {
    public struct BoundingBox {
        public let left, right, bottom, top: Float

        public init(left: Float, right: Float, bottom: Float, top: Float) {
            self.left = left
            self.right = right
            self.bottom = bottom
            self.top = top
        }
    }

    public let projectionMatrix: mat4
    public private(set) var viewMatrix: mat4
    public private(set) var viewProjectionMatrix: mat4

    public var position: vec3 {
        didSet { recalculateViewMatrix() }
    }

    public var rotation: Float {
        didSet { recalculateViewMatrix() }
    }


    public init(box: BoundingBox, near: Float = -1, far: Float = 1) {
        self.projectionMatrix = SGLMath.ortho(box.left, box.right, box.bottom, box.top, near, far)
        self.viewMatrix = .init(1)

        self.viewProjectionMatrix = self.projectionMatrix * self.viewMatrix

        self.position = .init()
        self.rotation = 0
    }

    private func recalculateViewMatrix() {
        let translate = SGLMath.translate(.init(), position)

        let transform: mat4
        if rotation == 0 {
            transform = translate
        } else {
            transform = SGLMath.rotate(translate, radians(rotation), [0, 0, 1])
        }

        self.viewMatrix = transform.inverse

        self.viewProjectionMatrix = self.projectionMatrix * self.viewMatrix
    }
}
