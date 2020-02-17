//
//  MacOSWindow.swift
//  Falcon
//
//  Created by Josef Zoller on 17.02.20.
//

#if os(macOS)

import GLFW

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
            
            isGLFWInitialized = true
        }
        
        self.glfwWindow = glfwCreateWindow(Int32(props.width), Int32(props.height), props.title, nil, nil)
        glfwMakeContextCurrent(glfwWindow)
        glfwSetWindowUserPointer(glfwWindow, &windowData)
        glfwSwapInterval(1)
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
