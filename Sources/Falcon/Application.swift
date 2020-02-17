//
//  Application.swift
//  Falcon
//
//  Created by Josef Zoller on 16.02.20.
//

import SGLOpenGL

open class Application {
    private let window: Window
    
    private var running = true
    
    public required init() {
        self.window = createWindow()
    }
    
    public func run() {
        while running {
            glClearColor(red: 1, green: 0, blue: 1, alpha: 1)
            glClear(GL_COLOR_BUFFER_BIT)
            window.onUpdate()
        }
    }
}
