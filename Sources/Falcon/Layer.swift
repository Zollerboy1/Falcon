//
//  Layer.swift
//  Falcon
//
//  Created by Josef Zoller on 17.02.20.
//

open class Layer: CustomStringConvertible {
    let name: String
    
    public init(name: String) {
        self.name = name
    }
    
    open var description: String { name }
    
    open func onAttach() {}
    open func onDetach() {}
    open func onUpdate() {}
    open func on(event: Event) {}
}
