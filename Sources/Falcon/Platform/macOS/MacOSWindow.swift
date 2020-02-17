//
//  MacOSWindow.swift
//  Falcon
//
//  Created by Josef Zoller on 17.02.20.
//

#if os(macOS)

import GLFW
import func glad.gladLoadGLLoader

fileprivate var isGLFWInitialized = false

class MacOSWindow: Window {
    
    struct WindowData {
        var title: String
        var width, height: Int32
        var vSync: Bool
        var eventCallback: ((Event) -> ())?
    }
    
    var windowData: WindowData
    var glfwWindow: OpaquePointer
    
    required init(withProperties props: WindowProperties) {
        self.windowData = WindowData(title: props.title, width: Int32(props.width), height: Int32(props.height), vSync: true, eventCallback: nil)
        
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
        
        self.glfwWindow = glfwCreateWindow(Int32(props.width), Int32(props.height), props.title, nil, nil)
        glfwMakeContextCurrent(glfwWindow)
        
        let status = gladLoadGLLoader { procname in
            unsafeBitCast(glfwGetProcAddress(procname), to: UnsafeMutableRawPointer.self)
        }
        Log.coreAssert(status == 1, "Could not initialize Glad!")
        
        glfwSetWindowUserPointer(glfwWindow, &windowData)
        glfwSwapInterval(1)
        
        glfwSetWindowSizeCallback(glfwWindow) { window, width, height in
            let data = glfwGetWindowUserPointer(window).assumingMemoryBound(to: WindowData.self)
            data[0].width = width
            data[0].height = height
            
            let event = WindowResizeEvent(width: Int(width), height: Int(height))
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
                let event = KeyPressedEvent(keyCode: Int(key), repeatCount: 0)
                data[0].eventCallback?(event)
            case GLFW_RELEASE:
                let event = KeyReleasedEvent(keyCode: Int(key))
                data[0].eventCallback?(event)
            case GLFW_REPEAT:
                let event = KeyPressedEvent(keyCode: Int(key), repeatCount: 1)
                data[0].eventCallback?(event)
            default:
                break
            }
        }
        
        glfwSetMouseButtonCallback(glfwWindow) { window, button, action, mods in
            let data = glfwGetWindowUserPointer(window).assumingMemoryBound(to: WindowData.self)
            
            switch action {
            case GLFW_PRESS:
                let event = MouseButtonPressedEvent(button: Int(button))
                data[0].eventCallback?(event)
            case GLFW_RELEASE:
                let event = MouseButtonReleasedEvent(button: Int(button))
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
    }
    
    deinit {
        glfwDestroyWindow(glfwWindow)
    }
    
    var width: Int { Int(windowData.width) }
    var height: Int { Int(windowData.height) }
    
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
        glfwSwapBuffers(glfwWindow)
    }
    
    func setEventCallback(_ callback: @escaping (Event) -> ()) {
        windowData.eventCallback = callback
    }
    
    
}

#endif
