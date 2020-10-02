//
//  main.swift
//  Sandbox
//
//  Created by Josef Zoller on 02.10.20.
//

import Falcon
import ImGui

class ExampleLayer: Layer {
    var imguiIsOpen = true

    init() {
        super.init(name: "Example")
    }

    override func onUpdate() {
        super.onUpdate()
    }

    override func onImGuiRender() {
        if imguiIsOpen {
            igBegin("Test", &imguiIsOpen, 0)
            igText("Hello World!")
            igEnd()
        }
    }
}

class Sandbox: Application {
    required init() {
        super.init()

        push(layer: ExampleLayer())
    }
}

EntryPoint.create(with: Sandbox.self)
