//
//  KeyCode.swift
//  Falcon
//
//  Created by Josef Zoller on 02.03.20.
//

// codes from GLFW
public enum KeyCode: Int {
    case unknown = -1
    
    case space = 32
    case apostrophe = 39
    
    case comma = 44
    case minus, period, slash
    
    case _0 = 48
    case _1, _2, _3, _4, _5, _6, _7, _8, _9
    
    case semicolon = 59
    case equal = 61
    
    case a = 65
    case b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z
    
    case leftBracket = 91
    case backslash, rightBracket
    
    case graveAccent = 96
    
    case world_1 = 161
    case world_2

    case escape = 256
    case enter, tab, backspace, insert, delete, right, left, down, up, pageUp, pageDown, home, end
    
    case capsLock = 280
    case scrollLock, numLock, printScreen, pause
    
    case f1 = 290
    case f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25
    
    case keyPad0 = 320
    case keyPad1, keyPad2, keyPad3, keyPad4, keyPad5, keyPad6, keyPad7, keyPad8, keyPad9, keyPadDecimal, keyPadDivide, keyPadMultiply, keyPadSubtract, keyPadAdd, keyPadEnter, keyPadEqual
    
    case leftShift = 340
    case leftControl, leftAlt, leftSuper, rightShift, rightControl, rightAlt, rightSuper
    
    case menu = 348
    
    public var cValue: Int32 { Int32(rawValue) }
    
    public static func from(GLFWKeyCode code: Int32) -> KeyCode {
        return KeyCode(rawValue: Int(code)) ?? .unknown
    }
}
