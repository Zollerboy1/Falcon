//
//  MacOSInput.swift
//  Falcon
//
//  Created by Josef Zoller on 02.03.20.
//

#if os(macOS)

import GLFW

class MacOSInput: Input {
    override func isKeyPressed(withKeyCode keyCode: KeyCode) -> Bool {
        let window = Application.instance!.window
        
        let state = glfwGetKey(window.nativeWindow, keyCode.cValue)
        
        return state == GLFW_PRESS || state == GLFW_REPEAT
    }
    
    override func isMouseButtonPressed(withButtonCode button: MouseButtonCode) -> Bool {
        let window = Application.instance!.window
        
        let state = glfwGetMouseButton(window.nativeWindow, button.cValue)
        
        return state == GLFW_PRESS
    }
    
    override func getMousePosition() -> (x: Double, y: Double) {
        let window = Application.instance!.window
        
        var x = 0.0, y = 0.0
        
        glfwGetCursorPos(window.nativeWindow, &x, &y)
        
        return (x, y)
    }
}

#endif
