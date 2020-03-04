//
//  Input.swift
//  Falcon
//
//  Created by Josef Zoller on 02.03.20.
//

public class Input {
    private static let instance: Input = {
        #if os(macOS)
            return MacOSInput()
        #endif
    }()
    
    internal func isKeyPressed(withKeyCode keyCode: KeyCode) -> Bool { return false }
    
    internal func isMouseButtonPressed(withButtonCode button: MouseButtonCode) -> Bool { return false }
    
    internal func getMousePosition() -> (x: Double, y: Double) { return (0, 0) }
    
    public static func isKeyPressed(withKeyCode keyCode: KeyCode) -> Bool {
        instance.isKeyPressed(withKeyCode: keyCode)
    }
    
    public static func isMouseButtonPressed(withButtonCode button: MouseButtonCode) -> Bool {
        instance.isMouseButtonPressed(withButtonCode: button)
    }
    
    public static var mousePosition: (x: Double, y: Double) { instance.getMousePosition() }
    
    public static var mouseX: Double { mousePosition.x }
    public static var mouseY: Double { mousePosition.y }
}
