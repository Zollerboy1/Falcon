//
//  ImGuiLayer.swift
//  Falcon
//
//  Created by Josef Zoller on 17.02.20.
//

import GLFW
import ImGui

internal class ImGuiLayer: Layer {
    internal private(set) var demoIsOpen: Bool
    
    internal init(demo: Bool) {
        self.demoIsOpen = demo
        
        super.init(name: "ImGuiLayer")
    }
    
    internal func openDemo() {
        self.demoIsOpen = true
    }
    
    internal func closeDemo() {
        self.demoIsOpen = false
    }
    
    internal override func onAttach() {
        igCheckVersion()
        _ = igCreateContext(nil)
        
        let io = igGetIO()!
        io.pointee.ConfigFlags |= Int32(CImGuiConfigFlags_NavEnableKeyboard.rawValue)
        io.pointee.ConfigFlags |= Int32(CImGuiConfigFlags_DockingEnable.rawValue)
        io.pointee.ConfigFlags |= Int32(CImGuiConfigFlags_ViewportsEnable.rawValue)
        
        io.pointee.FontGlobalScale = 0.5
        
        igStyleColorsDark(nil)
        
        ig_CImFontAtlas_AddFontFromFileTTF(io.pointee.Fonts, "/Users/admin/Library/Fonts/skyfonts-google/Fira Sans regular.ttf", 26, nil, nil)
        
        let style = igGetStyle()!
        style.pointee.WindowRounding = 0
        style[\.Colors].withMemoryRebound(to: CImVec4.self, capacity: Int(CImGuiCol_COUNT.rawValue)) { pointer in
            pointer[Int(CImGuiCol_WindowBg.rawValue)].w = 1
        }
        
        let app = Application.instance!
        
        let window = app.window.nativeWindow
        
        igImplGLFW_Init(window, true)
        igImplOpenGL_Init("#version 410")
    }
    
    internal override func onDetach() {
        igImplOpenGL_Shutdown()
        igImplGLFW_Shutdown()
        igDestroyContext(nil)
    }
    
    internal func begin() {
        igImplOpenGL_NewFrame()
        igImplGLFW_NewFrame()
        igNewFrame()
    }
    
    internal func end() {
        igRender()
        
        igImplOpenGL_RenderDrawData(igGetDrawData())
        
        let backup_current_context = glfwGetCurrentContext()
        igUpdatePlatformWindows()
        igRenderPlatformWindowsDefault(nil, nil)
        glfwMakeContextCurrent(backup_current_context)
    }
    
    internal func render() {
        if demoIsOpen {
            igShowDemoWindow(&demoIsOpen)
        }
    }
}
