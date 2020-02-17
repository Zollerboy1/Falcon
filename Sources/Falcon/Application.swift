//
//  Application.swift
//  Falcon
//
//  Created by Josef Zoller on 16.02.20.
//

import SGLOpenGL

open class Application {
    private let window = createWindow()
    private let layerStack = LayerStack()
    
    private var running = true
    
    public required init() {
        window.setEventCallback(self.on(event:))
    }
    
    private func on(event: Event) {
        let dispatcher = EventDispatcher(event: event)
        
        dispatcher.dispatch(callback: self.on(windowCloseEvent:))
        
        for layer in layerStack.reversed() {
            layer.on(event: event)
            
            if event.isHandled { break }
        }
    }
    
    private func on(windowCloseEvent event: WindowCloseEvent) -> Bool {
        running = false
        return true
    }
    
    
    public func push(layer: Layer) {
        layerStack.push(layer: layer)
    }
    
    public func push(overlay: Layer) {
        layerStack.push(overlay: overlay)
    }
    
    
    open func run() {
        while running {
            glClearColor(red: 1, green: 0, blue: 1, alpha: 1)
            glClear(GL_COLOR_BUFFER_BIT)
            
            for layer in layerStack {
                layer.onUpdate()
            }
            
            window.onUpdate()
        }
    }
}
