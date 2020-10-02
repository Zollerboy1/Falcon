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
    
    public static let none         = EventCategory([])
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


public protocol EventDelegate {
    func on(mouseButtonPressedEvent event: MouseButtonPressedEvent) -> Bool
    func on(mouseButtonReleasedEvent event: MouseButtonReleasedEvent) -> Bool
    func on(mouseMovedEvent event: MouseMovedEvent) -> Bool
    func on(mouseScrolledEvent event: MouseScrolledEvent) -> Bool
    
    func on(keyPressedEvent event: KeyPressedEvent) -> Bool
    func on(keyReleasedEvent event: KeyReleasedEvent) -> Bool
    func on(keyTypedEvent event: KeyTypedEvent) -> Bool
    
    func on(windowResizeEvent event: WindowResizeEvent) -> Bool
    func on(windowScaleChangeEvent event: WindowScaleChangeEvent) -> Bool
    func on(windowCloseEvent event: WindowCloseEvent) -> Bool
    
    func on(appTickEvent event: AppTickEvent) -> Bool
    func on(appUpdateEvent event: AppUpdateEvent) -> Bool
    func on(appRenderEvent event: AppRenderEvent) -> Bool
}

public extension EventDelegate {
    func on(event: Event) {
        let dispatcher = EventDispatcher(event: event)
        
        dispatcher.dispatch(callback: on(mouseButtonPressedEvent:))
        dispatcher.dispatch(callback: on(mouseButtonReleasedEvent:))
        dispatcher.dispatch(callback: on(mouseMovedEvent:))
        dispatcher.dispatch(callback: on(mouseScrolledEvent:))
        dispatcher.dispatch(callback: on(keyPressedEvent:))
        dispatcher.dispatch(callback: on(keyReleasedEvent:))
        dispatcher.dispatch(callback: on(keyTypedEvent:))
        dispatcher.dispatch(callback: on(windowResizeEvent:))
        dispatcher.dispatch(callback: on(windowScaleChangeEvent:))
        dispatcher.dispatch(callback: on(windowCloseEvent:))
        dispatcher.dispatch(callback: on(appTickEvent:))
        dispatcher.dispatch(callback: on(appUpdateEvent:))
        dispatcher.dispatch(callback: on(appRenderEvent:))
    }
}
