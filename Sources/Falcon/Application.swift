//
//  Application.swift
//  Falcon
//
//  Created by Josef Zoller on 16.02.20.
//

import glad

open class Application: EventDelegate {
    public private(set) static var instance: Application?
    
    public let window = WindowFactory.create()
    
    private let imGuiLayer: ImGuiLayer
    private let layerStack = LayerStack()
    private var running = true

    private var vertexArray: VertexArray!

    private var shader: Shader!

    private var squareVertexArray: VertexArray!
    private var blueShader: Shader!
    
    public required init() {
        self.imGuiLayer = ImGuiLayer(demo: true)
        
        Log.assert(Application.instance == nil, "Application already exists!")
        Application.instance = self
        
        push(overlay: self.imGuiLayer)
        
        window.setEventCallback(self.on(event:))


        self.vertexArray = Renderer.createVertexArray()

        let vertices: [Float] = [
            -0.5, -0.5, 0, 0.8, 0.2, 0.8, 1,
             0.5, -0.5, 0, 0.2, 0.2, 0.8, 1,
             0,    0.5, 0, 0.8, 0.8, 0.2, 1
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

            out vec3 v_Position;
            out vec4 v_Color;

            void main() {
                v_Position = a_Position;
                v_Color = a_Color;
                gl_Position = vec4(a_Position, 1.0);
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

            out vec3 v_Position;

            void main() {
                v_Position = a_Position;
                gl_Position = vec4(a_Position, 1.0);
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
    
    public func on(event: Event) {
        for layer in layerStack.reversed() {
            layer.on(event: event)
            
            if event.isHandled { break }
        }
        
        (self as EventDelegate).on(event: event)
    }
    
    
    public func push(layer: Layer) {
        layerStack.push(layer: layer)
    }
    
    public func push(overlay: Layer) {
        layerStack.push(overlay: overlay)
    }
    
    
    internal func update() {
        glad_glClearColor(0.1, 0.1, 0.1, 1)
        glad_glClear(GLbitfield(GL_COLOR_BUFFER_BIT))

        blueShader.bind()

        self.squareVertexArray.withBound {
            glad_glDrawElements(GLenum(GL_TRIANGLES), GLsizei(squareVertexArray.indexBuffer!.count), GLenum(GL_UNSIGNED_INT), nil)
        }

        shader.bind()

        self.vertexArray.withBound {
            glad_glDrawElements(GLenum(GL_TRIANGLES), GLsizei(vertexArray.indexBuffer!.count), GLenum(GL_UNSIGNED_INT), nil)
        }

        
        for layer in layerStack {
            layer.onUpdate()
        }
        
        imGuiLayer.begin()
        
        imGuiLayer.render()
        
        for layer in layerStack {
            layer.onImGuiRender()
        }
        
        imGuiLayer.end()
    }
    
    
    open func run() {
        while running {
            update()
            
            window.onUpdate()
        }
    }

    /// The @main attribute doesn't work with the swift package manager,
    /// so currently this method is useless
    public static func main() {
        Log.coreInfo("\(Falcon.welcomeMessage)")

        let application = Self.init()
        application.run()
    }
    
    
    open func on(mouseButtonPressedEvent event: MouseButtonPressedEvent) -> Bool {
        return false
    }
    
    open func on(mouseButtonReleasedEvent event: MouseButtonReleasedEvent) -> Bool {
        return false
    }
    
    open func on(mouseMovedEvent event: MouseMovedEvent) -> Bool {
        return false
    }
    
    open func on(mouseScrolledEvent event: MouseScrolledEvent) -> Bool {
        return false
    }
    
    
    open func on(keyPressedEvent event: KeyPressedEvent) -> Bool {
        return false
    }
    
    open func on(keyReleasedEvent event: KeyReleasedEvent) -> Bool {
        return false
    }
    
    open func on(keyTypedEvent event: KeyTypedEvent) -> Bool {
        return false
    }
    
    
    open func on(windowResizeEvent event: WindowResizeEvent) -> Bool {
        return false
    }
    
    open func on(windowScaleChangeEvent event: WindowScaleChangeEvent) -> Bool {
        return false
    }
    
    open func on(windowCloseEvent event: WindowCloseEvent) -> Bool {
        running = false
        return true
    }
    
    
    open func on(appTickEvent event: AppTickEvent) -> Bool {
        return false
    }
    
    open func on(appUpdateEvent event: AppUpdateEvent) -> Bool {
        return false
    }
    
    open func on(appRenderEvent event: AppRenderEvent) -> Bool {
        return false
    }
}
