//
//  MouseEvent.swift
//  Falcon
//
//  Created by Josef Zoller on 16.02.20.
//

public protocol MouseEvent: Event {}

public extension MouseEvent {
    static var category: EventCategory {
        return [.input, .mouse]
    }
}

public class MouseMovedEvent: MouseEvent {
    public private(set) var isHandled = false
    
    public func setHandled() {
        isHandled = true
    }
    
    public let x: Double
    public let y: Double
    
    internal init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    
    public var description: String {
        return "MouseMovedEvent: \(x), \(y)"
    }
}

public class MouseScrolledEvent: MouseEvent {
    public private(set) var isHandled = false
    
    public func setHandled() {
        isHandled = true
    }
    
    public let xOffset: Double
    public let yOffset: Double
    
    internal init(xOffset: Double, yOffset: Double) {
        self.xOffset = xOffset
        self.yOffset = yOffset
    }
    
    public var description: String {
        return "MouseScrolledEvent: \(xOffset), \(yOffset)"
    }
}


public protocol MouseButtonEvent: MouseEvent {
    var button: Int { get }
}

public extension MouseButtonEvent {
    static var category: EventCategory {
        return [.input, .mouse, .mouseButton]
    }
}

public class MouseButtonPressedEvent: MouseButtonEvent {
    public private(set) var isHandled = false
    
    public func setHandled() {
        isHandled = true
    }
    
    public let button: Int
    
    internal init(button: Int) {
        self.button = button
    }
    
    public var description: String {
        return "MouseButtonPressedEvent: \(button)"
    }
}

public class MouseButtonReleasedEvent: MouseButtonEvent {
    public private(set) var isHandled = false
    
    public func setHandled() {
        isHandled = true
    }
    
    public let button: Int
    
    internal init(button: Int) {
        self.button = button
    }
    
    public var description: String {
        return "MouseButtonReleasedEvent: \(button)"
    }
}


