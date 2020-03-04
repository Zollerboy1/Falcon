//
//  Application.swift
//  Falcon
//
//  Created by Josef Zoller on 16.02.20.
//

import glad

open class Application: EventDelegate {
    public private(set) static var instance: Application?
    
    public let window = createWindow()
    
    private let layerStack = LayerStack()
    private var running = true
    
    public required init() {
        window.setEventCallback(self.on(event:))
        
        Log.assert(Application.instance == nil, "Application already exists!")
        Application.instance = self
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
        glad_glClearColor(1, 0, 1, 1)
        glad_glClear!(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        for layer in layerStack {
            layer.onUpdate()
        }
    }
    
    
    open func run() {
        while running {
            update()
            
            window.onUpdate()
        }
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
