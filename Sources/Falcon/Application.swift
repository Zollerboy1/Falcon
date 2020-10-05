//
//  Application.swift
//  Falcon
//
//  Created by Josef Zoller on 16.02.20.
//

import SGLMath
import GLFW

open class Application: EventDelegate {
    public private(set) static var instance: Application?
    
    public let window = WindowFactory.create()
    
    private let imGuiLayer: ImGuiLayer
    private let layerStack = LayerStack()
    private var running = true

    private var lastFrameTime = 0.0
    
    public required init() {
        imGuiLayer = ImGuiLayer(demo: false)
        
        Log.assert(Application.instance == nil, "Application already exists!")
        Application.instance = self
        
        push(overlay: imGuiLayer)
        
        window.setEventCallback(on(event:))
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


    private func deltaTime() -> Timestep {
        let time = glfwGetTime()
        let timestep = Timestep(time: time - lastFrameTime)

        lastFrameTime = time

        return timestep
    }
    
    
    internal func update() {
        let timestep = deltaTime()

        for layer in layerStack {
            layer.onUpdate(deltaTime: timestep)
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
