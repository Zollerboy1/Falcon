//
//  main.swift
//  Sandbox
//
//  Created by Josef Zoller on 02.10.20.
//

import Falcon
import ImGui
import SGLMath

class ExampleLayer: Layer {
    var imguiIsOpen = false

    private let camera = OrthographicCamera(box: .init(left: -1.6, right: 1.6, bottom: -0.9, top: 0.9))

    private static let cameraMoveSpeed: Float = 1
    private static let cameraRotationSpeed: Float = 45

    private var vertexArray: VertexArray!
    private var shader: Shader!

    private var squareVertexArray: VertexArray!
    private var blueShader: Shader!

    init() {
        super.init(name: "Example")


        self.vertexArray = Renderer.createVertexArray()

        let vertices: [Float] = [
            -0.75, -0.5, 0, 0.8, 0.2, 0.8, 1,
             0.75, -0.5, 0, 0.2, 0.2, 0.8, 1,
             0,     0.5, 0, 0.8, 0.8, 0.2, 1
        ]

        self.vertexArray.add(vertexBuffer: Renderer.createVertexBuffer(withVertices: vertices) {
            ShaderFloat3(withName: "a_Position")
            ShaderFloat4(withName: "a_Color")
        })

        self.vertexArray.indexBuffer = Renderer.createIndexBuffer(withIndices: [0, 1, 2])


        self.squareVertexArray = Renderer.createVertexArray()

        let squareVertices: [Float] = [
            -0.75, -0.75, 0,
             0.75, -0.75, 0,
             0.75,  0.75, 0,
            -0.75,  0.75, 0
        ]

        self.squareVertexArray.add(vertexBuffer: Renderer.createVertexBuffer(withVertices: squareVertices) {
            ShaderFloat3(withName: "a_Position")
        })

        self.squareVertexArray.indexBuffer = Renderer.createIndexBuffer(withIndices: [0, 1, 2, 2, 3, 0])


        let vertexShaderSource = """
            #version 410

            layout (location = 0) in vec3 a_Position;
            layout (location = 1) in vec4 a_Color;

            uniform mat4 u_ViewProjection;

            out vec3 v_Position;
            out vec4 v_Color;

            void main() {
                v_Position = a_Position;
                v_Color = a_Color;
                gl_Position = u_ViewProjection * vec4(a_Position, 1.0);
            }
            """

        let fragmentShaderSource = """
            #version 410

            in vec3 v_Position;
            in vec4 v_Color;

            out vec4 FragColor;

            void main() {
                FragColor = vec4(v_Position + 0.5, 1.0);
                FragColor = v_Color;
            }
            """

        self.shader = Shader(vertexSource: vertexShaderSource, fragmentSource: fragmentShaderSource)



        let blueVertexShaderSource = """
            #version 410

            layout (location = 0) in vec3 a_Position;

            uniform mat4 u_ViewProjection;

            out vec3 v_Position;

            void main() {
                v_Position = a_Position;
                gl_Position = u_ViewProjection * vec4(a_Position, 1.0);
            }
            """

        let blueFragmentShaderSource = """
            #version 410

            in vec3 v_Position;

            out vec4 FragColor;

            void main() {
                FragColor = vec4(0.2, 0.3, 0.8, 1.0);
            }
            """

        self.blueShader = Shader(vertexSource: blueVertexShaderSource, fragmentSource: blueFragmentShaderSource)
    }

    override func onUpdate(deltaTime timestep: Timestep) {
        super.onUpdate(deltaTime: timestep)

        RenderCommand.set(clearColor: vec4(r: 0.1, g: 0.1, b: 0.1, a: 1))
        RenderCommand.clear()

        if Input.isKeyPressed(withKeyCode: .a) {
            self.camera.position.x -= ExampleLayer.cameraMoveSpeed * timestep
        } else if Input.isKeyPressed(withKeyCode: .d) {
            self.camera.position.x += ExampleLayer.cameraMoveSpeed * timestep
        }

        if Input.isKeyPressed(withKeyCode: .s) {
            self.camera.position.y -= ExampleLayer.cameraMoveSpeed * timestep
        } else if Input.isKeyPressed(withKeyCode: .w) {
            self.camera.position.y += ExampleLayer.cameraMoveSpeed * timestep
        }

        if Input.isKeyPressed(withKeyCode: .left) {
            self.camera.rotation += ExampleLayer.cameraRotationSpeed * timestep
        } else if Input.isKeyPressed(withKeyCode: .right) {
            self.camera.rotation -= ExampleLayer.cameraRotationSpeed * timestep
        }

        Renderer.scene(withCamera: self.camera) {
            Renderer.submit(vertexArray: self.squareVertexArray, withShader: self.blueShader)
            Renderer.submit(vertexArray: self.vertexArray, withShader: self.shader)
        }
    }

    override func onImGuiRender() {
        if imguiIsOpen {
            igBegin("Test", &imguiIsOpen, 0)
            igText("Hello World!")
            igEnd()
        }
    }
}

class Sandbox: Application {
    required init() {
        super.init()

        push(layer: ExampleLayer())
    }
}

EntryPoint.create(with: Sandbox.self)
