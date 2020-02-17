//
//  Window.swift
//  Falcon
//
//  Created by Josef Zoller on 17.02.20.
//

public struct WindowProperties {
    public let title: String
    public let width: Int
    public let height: Int
    
    public init(title: String = "Falcon Engine", width: Int = 1280, height: Int = 720) {
        self.title = title
        self.width = width
        self.height = height
    }
}

public protocol Window {
    init(withProperties properties: WindowProperties)
    
    var width: Int { get }
    var height: Int { get }
    
    var isVsyncEnabled: Bool { get set }
    
    func onUpdate()
    
    func setEventCallback(_ callback: @escaping (Event) -> ())
}

public func createWindow(withProperties properties: WindowProperties = WindowProperties()) -> Window {
    #if os(macOS)
        return MacOSWindow(withProperties: properties)
    #endif
}


