//
//  Application.swift
//  Falcon
//
//  Created by Josef Zoller on 16.02.20.
//

import SGLOpenGL

open class Application {
    private let window = createWindow()
    
    private var running = true
    
    public required init() {
        window.setEventCallback(self.on(event:))
    }
    
    private func on(event: Event) {
        let dispatcher = EventDispatcher(event: event)
        
        dispatcher.dispatch(callback: self.on(windowCloseEvent:))
        
        Log.coreInfo("\(event)")
    }
    
    private func on(windowCloseEvent event: WindowCloseEvent) -> Bool {
        running = false
        return true
    }
    
    
    open func run() {
        while running {
            glClearColor(red: 1, green: 0, blue: 1, alpha: 1)
            glClear(GL_COLOR_BUFFER_BIT)
            
            window.onUpdate()
        }
    }
}
