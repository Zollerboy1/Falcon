//
//  MouseButtonCode.swift
//  Falcon
//
//  Created by Josef Zoller on 02.03.20.
//

import GLFW

// codes from GLFW
public enum MouseButtonCode: Int {
    case _1 = 0
    case _2, _3, _4, _5, _6, _7, _8
    
    static let last = _8
    static let left = _1
    static let right = _2
    static let middle = _3
    
    public var cValue: Int32 { Int32(rawValue) }
    
    public static func from(GLFWMouseButtonCode code: Int32) -> MouseButtonCode {
        return MouseButtonCode(rawValue: Int(code))!
    }
}
