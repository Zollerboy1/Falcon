//
//  LayerStack.swift
//  Falcon
//
//  Created by Josef Zoller on 17.02.20.
//

public class LayerStack: Collection {
    public typealias Underlying = [Layer]
    
    private var layers = Underlying()
    private var layerInsert: Index
    
    init() {
        layerInsert = layers.startIndex
    }
    
    public typealias Element = Underlying.Element
    public typealias Index = Underlying.Index
    
    public var startIndex: Index { return layers.startIndex }
    public var endIndex: Index { return layers.endIndex }
    
    public subscript(index: Index) -> Iterator.Element {
        get { return layers[index] }
    }
    
    public func index(after i: Index) -> Index {
        return layers.index(after: i)
    }
}

extension LayerStack: BidirectionalCollection {
    public func index(before i: Index) -> Index {
        return layers.index(before: i)
    }
}

public extension LayerStack {
    func push(layer: Layer) {
        layers.insert(layer, at: layerInsert)
        layerInsert = index(after: layerInsert)
    }
    
    func push(overlay: Layer) {
        layers.append(overlay)
    }
    
    func pop(layer: Layer) {
        if let i = firstIndex(where: { $0 === layer }) {
            layers.remove(at: i)
            layerInsert = index(before: layerInsert)
        }
    }
    
    func pop(overlay: Layer) {
        if let i = firstIndex(where: { $0 === overlay }) {
            layers.remove(at: i)
        }
    }
}
