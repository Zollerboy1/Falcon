//
//  GLFWWindow.swift
//  Falcon
//
//  Created by Josef Zoller on 17.02.20.
//

#if os(macOS)

import Foundation
import GLFW

fileprivate var isGLFWInitialized = false

class GLFWWindow: Window {
    struct WindowData {
        var title: String
        var width, height: Int
        var xScale, yScale: Float
        var vSync: Bool
        var eventCallback: ((Event) -> ())?
    }

    let glfwWindow: OpaquePointer
    let graphicsContext: GraphicsContext

    var windowData: WindowData
    
    required init(withProperties props: WindowProperties) {
        Log.coreInfo("Creating Window '\(props.title)' (\(props.width), \(props.height))")
        
        if !isGLFWInitialized {
            let success = glfwInit()
            Log.coreAssert(success == 1, "Could not initialize GLFW!")
            
            glfwSetErrorCallback { error, description in
                let description = String(cString: description ?? UnsafePointer(UnsafeMutablePointer<Int8>.allocate(capacity: 0)), encoding: .utf8) ?? ""
                
                Log.coreError("GLFW Error (\(error)): \(description)")
            }
            
            isGLFWInitialized = true
        }
        
        glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 4)
        glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 1)
        glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE)
        glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, 1)
        
        self.glfwWindow = glfwCreateWindow(Int32(props.width), Int32(props.height), props.title, nil, nil)

        switch Renderer.currentAPI {
        #if canImport(glad)
        case .openGL:
            self.graphicsContext = OpenGLContext(windowHandle: glfwWindow)
        #endif

        case .none:
            Log.coreFatal("Have no renderer API!")
        }
        
        var xScale: Float = 0, yScale: Float = 0
        glfwGetWindowContentScale(glfwWindow, &xScale, &yScale)
        
        self.windowData = WindowData(title: props.title, width: props.width, height: props.height, xScale: xScale, yScale: yScale, vSync: true, eventCallback: nil)
        
        
        glfwSetWindowUserPointer(glfwWindow, &windowData)

        self.isVsyncEnabled = true
        
        
        glfwSetWindowSizeCallback(glfwWindow) { window, width, height in
            let data = glfwGetWindowUserPointer(window).assumingMemoryBound(to: WindowData.self)
            data[0].width = Int(width)
            data[0].height = Int(height)
            
            let event = WindowResizeEvent(width: Int(width), height: Int(height))
            data[0].eventCallback?(event)
        }
        
        glfwSetWindowContentScaleCallback(glfwWindow) { window, xScale, yScale in
            let data = glfwGetWindowUserPointer(window).assumingMemoryBound(to: WindowData.self)
            data[\.xScale].pointee = xScale
            data[\.yScale].pointee = yScale
            
            let event = WindowScaleChangeEvent(xScale: xScale, yScale: yScale)
            data[0].eventCallback?(event)
        }
        
        glfwSetWindowCloseCallback(glfwWindow) { window in
            let data = glfwGetWindowUserPointer(window).assumingMemoryBound(to: WindowData.self)
            
            let event = WindowCloseEvent()
            data[0].eventCallback?(event)
        }
        
        glfwSetKeyCallback(glfwWindow) { window, key, scancode, action, mods in
            let data = glfwGetWindowUserPointer(window).assumingMemoryBound(to: WindowData.self)
            
            switch action {
            case GLFW_PRESS:
                let event = KeyPressedEvent(keyCode: .from(GLFWKeyCode: key), repeatCount: 0)
                data[0].eventCallback?(event)
            case GLFW_RELEASE:
                let event = KeyReleasedEvent(keyCode: .from(GLFWKeyCode: key))
                data[0].eventCallback?(event)
            case GLFW_REPEAT:
                let event = KeyPressedEvent(keyCode: .from(GLFWKeyCode: key), repeatCount: 1)
                data[0].eventCallback?(event)
            default:
                break
            }
        }
        
        glfwSetCharCallback(glfwWindow) { window, character in
            let data = glfwGetWindowUserPointer(window).assumingMemoryBound(to: WindowData.self)
            
            let event = KeyTypedEvent(character: character)
            data[0].eventCallback?(event)
        }
        
        glfwSetMouseButtonCallback(glfwWindow) { window, button, action, mods in
            let data = glfwGetWindowUserPointer(window).assumingMemoryBound(to: WindowData.self)
            
            switch action {
            case GLFW_PRESS:
                let event = MouseButtonPressedEvent(button: .from(GLFWMouseButtonCode: button))
                data[0].eventCallback?(event)
            case GLFW_RELEASE:
                let event = MouseButtonReleasedEvent(button: .from(GLFWMouseButtonCode: button))
                data[0].eventCallback?(event)
            default:
                break
            }
        }
        
        glfwSetScrollCallback(glfwWindow) { window, xOffset, yOffset in
            let data = glfwGetWindowUserPointer(window).assumingMemoryBound(to: WindowData.self)
            
            let event = MouseScrolledEvent(xOffset: xOffset, yOffset: yOffset)
            data[0].eventCallback?(event)
        }
        
        glfwSetCursorPosCallback(glfwWindow) { window, x, y in
            let data = glfwGetWindowUserPointer(window).assumingMemoryBound(to: WindowData.self)
            
            let event = MouseMovedEvent(x: x, y: y)
            data[0].eventCallback?(event)
        }
        
        glfwSetWindowRefreshCallback(glfwWindow) { window in
            glfwSwapBuffers(window)
            
            Application.instance!.update()
        }
    }
    
    deinit {
        glfwDestroyWindow(glfwWindow)
    }
    
    var width: Int { windowData.width }
    var height: Int { windowData.height }
    var xScale: Float { windowData.xScale }
    var yScale: Float { windowData.yScale }
    
    var nativeWindow: OpaquePointer { self.glfwWindow }
    
    var isVsyncEnabled: Bool {
        get { windowData.vSync }
        set {
            if newValue {
                glfwSwapInterval(1)
            } else {
                glfwSwapInterval(0)
            }
            
            windowData.vSync = newValue
        }
    }
    
    func onUpdate() {
        glfwPollEvents()

        self.graphicsContext.swapBuffers()
    }
    
    func setEventCallback(_ callback: @escaping (Event) -> ()) {
        windowData.eventCallback = callback
    }
}

#endif
