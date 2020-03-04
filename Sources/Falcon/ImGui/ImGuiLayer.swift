//
//  ImGuiLayer.swift
//  Falcon
//
//  Created by Josef Zoller on 17.02.20.
//

import CImGuiOpenGLImpl
import glad
import GLFW
import ImGui

func makeImColor(red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8) -> UInt32 {
    return (UInt32(red) << 24) | (UInt32(green) << 16) | (UInt32(blue) << 8) | UInt32(alpha)
}

public class ImGuiLayer: Layer {
    var time = 0.0
    
    var showDemo: Bool
    
    var context: ImGuiContext?
    
    public init(showDemo: Bool) {
        self.showDemo = showDemo
        
        super.init(name: "ImGuiLayer")
    }
    
    public override func onAttach() {
        context = ImGuiCreateContext(nil)
        
        ImGuiStyleColorsDark(nil)
        
        let io = ImGuiGetIO()!
        io[\.BackendFlags].pointee |= Int32(ImGuiBackendFlags_HasMouseCursors.rawValue)
        io[\.BackendFlags].pointee |= Int32(ImGuiBackendFlags_HasSetMousePos.rawValue)
        
        io[\.KeyMap].pointee.0 = KeyCode.tab.cValue
        io[\.KeyMap].pointee.1 = KeyCode.left.cValue
        io[\.KeyMap].pointee.2 = KeyCode.right.cValue
        io[\.KeyMap].pointee.3 = KeyCode.up.cValue
        io[\.KeyMap].pointee.4 = KeyCode.down.cValue
        io[\.KeyMap].pointee.5 = KeyCode.pageUp.cValue
        io[\.KeyMap].pointee.6 = KeyCode.pageDown.cValue
        io[\.KeyMap].pointee.7 = KeyCode.home.cValue
        io[\.KeyMap].pointee.8 = KeyCode.end.cValue
        io[\.KeyMap].pointee.9 = KeyCode.insert.cValue
        io[\.KeyMap].pointee.10 = KeyCode.delete.cValue
        io[\.KeyMap].pointee.11 = KeyCode.backspace.cValue
        io[\.KeyMap].pointee.12 = KeyCode.space.cValue
        io[\.KeyMap].pointee.13 = KeyCode.enter.cValue
        io[\.KeyMap].pointee.14 = KeyCode.escape.cValue
        io[\.KeyMap].pointee.15 = KeyCode.keyPadEnter.cValue
        io[\.KeyMap].pointee.16 = KeyCode.a.cValue
        io[\.KeyMap].pointee.17 = KeyCode.c.cValue
        io[\.KeyMap].pointee.18 = KeyCode.v.cValue
        io[\.KeyMap].pointee.19 = KeyCode.x.cValue
        io[\.KeyMap].pointee.20 = KeyCode.y.cValue
        io[\.KeyMap].pointee.21 = KeyCode.z.cValue
        
        CImGui_ImplOpenGL3_Init()
    }
    
    public override func onDetach() {
        CImGui_ImplOpenGL3_Shutdown()
    }
    
    public override func onUpdate() {
        super.onUpdate()
        
        let app = Application.instance!
        let time = glfwGetTime()
        
        let io = ImGuiGetIO()!
        
        io[\.DisplaySize].pointee = ImVec2(x: Float(app.window.width), y: Float(app.window.height))
        io[\.DisplayFramebufferScale].pointee = ImVec2(x: app.window.xScale, y: app.window.yScale)
        
        io[\.FontGlobalScale].pointee = 1 / app.window.xScale
        _ = ImFontAtlasAddFontFromFileTTF(io[\.Fonts].pointee, "/Users/admin/Library/Fonts/skyfonts-google/Fira Sans regular.ttf", 13 * app.window.xScale, nil, nil)
        
        io[\.DeltaTime].pointee = Float(self.time > 0 ? (time - self.time) : (1 / 60))
        
        self.time = time
        
        CImGui_ImplOpenGL3_NewFrame()
        ImGuiNewFrame()
        
        ImGuiShowDemoWindow(&showDemo)
        
        ImGuiRender()
        CImGui_ImplOpenGL3_RenderDrawData(ImGuiGetDrawData())
    }
    
    
    public override func on(mouseButtonPressedEvent event: MouseButtonPressedEvent) -> Bool {
        let io = ImGuiGetIO()!
        
        io[\.MouseDown].withMemoryRebound(to: Bool.self, capacity: Mirror(reflecting: io[\.MouseDown].pointee).children.count) { pointer in
            pointer[event.button.rawValue] = true
        }
        
        return false
    }
    
    public override func on(mouseButtonReleasedEvent event: MouseButtonReleasedEvent) -> Bool {
        let io = ImGuiGetIO()!
        
        io[\.MouseDown].withMemoryRebound(to: Bool.self, capacity: Mirror(reflecting: io[\.MouseDown].pointee).children.count) { pointer in
            pointer[event.button.rawValue] = false
        }
        
        return false
    }
    
    public override func on(mouseMovedEvent event: MouseMovedEvent) -> Bool {
        let io = ImGuiGetIO()!
        
        io[\.MousePos].pointee = ImVec2(x: Float(event.x), y: Float(event.y))
        
        return false
    }
    
    public override func on(mouseScrolledEvent event: MouseScrolledEvent) -> Bool {
        let io = ImGuiGetIO()!
        
        io[\.MouseWheel].pointee += Float(event.yOffset)
        io[\.MouseWheelH].pointee += Float(event.xOffset)
        
        return false
    }
    
    
    public override func on(keyPressedEvent event: KeyPressedEvent) -> Bool {
        let io = ImGuiGetIO()!
        
        io[\.KeysDown].withMemoryRebound(to: Bool.self, capacity: Mirror(reflecting: io[\.KeysDown].pointee).children.count) { pointer in
            pointer[event.keyCode.rawValue] = true
            
            io[\.KeyCtrl].pointee = pointer[KeyCode.leftControl.rawValue] || pointer[KeyCode.rightControl.rawValue]
            io[\.KeyShift].pointee = pointer[KeyCode.leftShift.rawValue] || pointer[KeyCode.rightShift.rawValue]
            io[\.KeyAlt].pointee = pointer[KeyCode.leftAlt.rawValue] || pointer[KeyCode.rightAlt.rawValue]
            io[\.KeySuper].pointee = pointer[KeyCode.leftSuper.rawValue] || pointer[KeyCode.rightSuper.rawValue]
        }
        
        return false
    }
    
    public override func on(keyReleasedEvent event: KeyReleasedEvent) -> Bool {
        let io = ImGuiGetIO()!
        
        io[\.KeysDown].withMemoryRebound(to: Bool.self, capacity: Mirror(reflecting: io[\.KeysDown].pointee).children.count) { pointer in
            pointer[event.keyCode.rawValue] = false
            
            io[\.KeyCtrl].pointee = pointer[KeyCode.leftControl.rawValue] || pointer[KeyCode.rightControl.rawValue]
            io[\.KeyShift].pointee = pointer[KeyCode.leftShift.rawValue] || pointer[KeyCode.rightShift.rawValue]
            io[\.KeyAlt].pointee = pointer[KeyCode.leftAlt.rawValue] || pointer[KeyCode.rightAlt.rawValue]
            io[\.KeySuper].pointee = pointer[KeyCode.leftSuper.rawValue] || pointer[KeyCode.rightSuper.rawValue]
        }
        
        return false
    }
    
    public override func on(keyTypedEvent event: KeyTypedEvent) -> Bool {
        let io = ImGuiGetIO()!
        
        if (1..<0x10000).contains(event.character) {
            ImGuiIOAddInputCharacter(io, event.character)
        }
        
        return false
    }
    
    public override func on(windowResizeEvent event: WindowResizeEvent) -> Bool {
        let io = ImGuiGetIO()!
        io[\.DisplaySize].pointee = ImVec2(x: Float(event.width), y: Float(event.height))
        
        glad_glViewport!(0, 0, GLsizei(event.width), GLsizei(event.height))
        
        return false
    }
    
    public override func on(windowScaleChangeEvent event: WindowScaleChangeEvent) -> Bool {
        let io = ImGuiGetIO()!
        io[\.DisplayFramebufferScale].pointee = ImVec2(x: event.xScale, y: event.yScale)
        
        return false
    }
}
