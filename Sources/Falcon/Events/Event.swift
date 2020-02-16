//
//  Event.swift
//  Falcon
//
//  Created by Josef Zoller on 16.02.20.
//

public struct EventCategory: OptionSet {
    public let rawValue: UInt8
    
    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }
    
    public static let none         = EventCategory(rawValue: 0)
    public static let application  = EventCategory(rawValue: 1 << 0)
    public static let input        = EventCategory(rawValue: 1 << 1)
    public static let keyboard     = EventCategory(rawValue: 1 << 2)
    public static let mouse        = EventCategory(rawValue: 1 << 3)
    public static let mouseButton  = EventCategory(rawValue: 1 << 4)
}

public protocol Event: CustomStringConvertible {
    static var category: EventCategory { get }
    
    var isHandled: Bool { get }
    
    func setHandled()
}

public extension Event {
    func belongsTo(category: EventCategory) -> Bool {
        return Self.category.contains(category)
    }
    
    var description: String { return String(describing: self) }
}


public struct EventDispatcher {
    public let event: Event
    
    public init(event: Event) {
        self.event = event
    }
    
    public func dispatch<T>(callback: (T) -> Bool) where T: Event {
        if let event = self.event as? T, callback(event) {
            self.event.setHandled()
        }
    }
}
