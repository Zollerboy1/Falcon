//
//  KeyEvent.swift
//  Falcon
//
//  Created by Josef Zoller on 16.02.20.
//

public protocol KeyEvent: Event {}

public extension KeyEvent {
    static var category: EventCategory {
        return [.input, .keyboard]
    }
}

public class KeyPressedEvent: KeyEvent {
    public private(set) var isHandled = false
    
    public func setHandled() {
        isHandled = true
    }
    
    public let keyCode: KeyCode
    public let repeatCount: Int
    
    internal init(keyCode: KeyCode, repeatCount: Int) {
        self.keyCode = keyCode
        self.repeatCount = repeatCount
    }
    
    public var description: String {
        return "KeyPressedEvent: \(keyCode) (\(repeatCount) repeat\(repeatCount != 1 ? "s" : ""))"
    }
}

public class KeyReleasedEvent: KeyEvent {
    public private(set) var isHandled = false
    
    public func setHandled() {
        isHandled = true
    }
    
    public let keyCode: KeyCode
    
    internal init(keyCode: KeyCode) {
        self.keyCode = keyCode
    }
    
    public var description: String {
        return "KeyReleasedEvent: \(keyCode)"
    }
}

public class KeyTypedEvent: KeyEvent {
    public private(set) var isHandled = false
    
    public func setHandled() {
        isHandled = true
    }
    
    public let character: UInt32
    
    internal init(character: UInt32) {
        self.character = character
    }
    
    public var description: String {
        return "KeyReleasedEvent: \(character)"
    }
}


