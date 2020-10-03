//
//  Input.swift
//  Falcon
//
//  Created by Josef Zoller on 02.03.20.
//

public class Input {
    private static let main: Input = {
        #if os(macOS)
            return GLFWInput()
        #endif
    }()
    
    internal func isKeyPressed(withKeyCode keyCode: KeyCode) -> Bool { return false }
    
    internal func isMouseButtonPressed(withButtonCode button: MouseButtonCode) -> Bool { return false }
    
    internal func getMousePosition() -> (x: Double, y: Double) { return (0, 0) }
    
    public static func isKeyPressed(withKeyCode keyCode: KeyCode) -> Bool {
        main.isKeyPressed(withKeyCode: keyCode)
    }
    
    public static func isMouseButtonPressed(withButtonCode button: MouseButtonCode) -> Bool {
        main.isMouseButtonPressed(withButtonCode: button)
    }
    
    public static var mousePosition: (x: Double, y: Double) { main.getMousePosition() }
    
    public static var mouseX: Double { mousePosition.x }
    public static var mouseY: Double { mousePosition.y }
}
