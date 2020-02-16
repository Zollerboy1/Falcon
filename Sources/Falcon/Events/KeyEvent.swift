//
//  KeyEvent.swift
//  Falcon
//
//  Created by Josef Zoller on 16.02.20.
//

public protocol KeyEvent: Event {
    var keyCode: Int { get }
}

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
    
    public let keyCode: Int
    public let repeatCount: Int
    
    internal init(keyCode: Int, repeatCount: Int) {
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
    
    public let keyCode: Int
    
    internal init(keyCode: Int) {
        self.keyCode = keyCode
    }
    
    public var description: String {
        return "KeyReleasedEvent: \(keyCode)"
    }
}


