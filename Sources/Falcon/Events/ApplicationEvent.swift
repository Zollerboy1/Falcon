//
//  ApplicationEvent.swift
//  Falcon
//
//  Created by Josef Zoller on 16.02.20.
//

public protocol ApplicationEvent: Event {}

public extension ApplicationEvent {
    static var category: EventCategory {
        return .application
    }
}

public class WindowResizeEvent: ApplicationEvent {
    public private(set) var isHandled = false
    
    public func setHandled() {
        isHandled = true
    }
    
    public let width: Int
    public let height: Int
    
    internal init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
    
    public var description: String {
        return "WindowResizeEvent: \(width), \(height)"
    }
}

public class WindowCloseEvent: ApplicationEvent {
    public private(set) var isHandled = false
    
    public func setHandled() {
        isHandled = true
    }
    
    internal init() {}
    
    public var description: String {
        return "WindowCloseEvent"
    }
}


public class AppTickEvent: ApplicationEvent {
    public private(set) var isHandled = false
    
    public func setHandled() {
        isHandled = true
    }
    
    internal init() {}
    
    public var description: String {
        return "AppTickEvent"
    }
}

public class AppUpdateEvent: ApplicationEvent {
    public private(set) var isHandled = false
    
    public func setHandled() {
        isHandled = true
    }
    
    internal init() {}
    
    public var description: String {
        return "AppUpdateEvent"
    }
}

public class AppRenderEvent: ApplicationEvent {
    public private(set) var isHandled = false
    
    public func setHandled() {
        isHandled = true
    }
    
    internal init() {}
    
    public var description: String {
        return "AppRenderEvent"
    }
}
