//
//  UnsafePointer+KeyPathSubscript.swift
//  Falcon
//
//  Created by Josef Zoller on 20.02.20.
//

extension UnsafePointer {
    subscript<T>(_ keyPath: KeyPath<Pointee, T>) -> UnsafePointer<T> {
        let raw = UnsafeRawPointer(self)
        // If a key path is not directly-addressable I consider it programmer error
        let offset = MemoryLayout<Pointee>.offset(of: keyPath)!
        return raw.advanced(by: offset).assumingMemoryBound(to: T.self)
    }
}

extension UnsafeMutablePointer {
    subscript<T>(_ keyPath: KeyPath<Pointee, T>) -> UnsafeMutablePointer<T> {
        let raw = UnsafeMutableRawPointer(self)
        // If a key path is not directly-addressable I consider it programmer error
        let offset = MemoryLayout<Pointee>.offset(of: keyPath)!
        return raw.advanced(by: offset).assumingMemoryBound(to: T.self)
    }
}
