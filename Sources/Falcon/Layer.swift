//
//  Layer.swift
//  Falcon
//
//  Created by Josef Zoller on 17.02.20.
//

open class Layer: CustomStringConvertible, EventDelegate {
    let name: String
    
    public init(name: String) {
        self.name = name
    }
    
    open var description: String { name }
    
    open func onAttach() {}
    open func onDetach() {}
    open func onUpdate() {}
    
    open func onImGuiRender() {}
    
    //Default implementations
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
        return false
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
