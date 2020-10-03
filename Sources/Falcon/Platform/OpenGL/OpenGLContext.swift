//
//  OpenGLContext.swift
//  Falcon
//
//  Created by Josef Zoller on 03.10.20.
//

#if canImport(glad)

import glad
import GLFW

class OpenGLContext: GraphicsContext {
    private let windowHandle: OpaquePointer

    init(windowHandle: OpaquePointer) {
        self.windowHandle = windowHandle

        glfwMakeContextCurrent(windowHandle)

        let status = gladLoadGLLoader { procname in
            unsafeBitCast(glfwGetProcAddress(procname), to: UnsafeMutableRawPointer.self)
        }

        Log.coreAssert(status == 1, "Could not initialize Glad!")

        Log.coreInfo("OpenGL Info:")
        Log.coreInfo("  Vendor:   \(String(cString: glad_glGetString(GLenum(GL_VENDOR))!))")
        Log.coreInfo("  Renderer: \(String(cString: glad_glGetString(GLenum(GL_RENDERER))!))")
        Log.coreInfo("  Version:  \(String(cString: glad_glGetString(GLenum(GL_VERSION))!))")
    }

    func swapBuffers() {
        glfwSwapBuffers(windowHandle)
    }
}

#endif
