//
//  Shader.swift
//  Falcon
//
//  Created by Josef Zoller on 03.10.20.
//

import glad

public class Shader {
    private let id: UInt32

    public init?(vertexSource: String, fragmentSource: String) {
        let vertexShaderID = glad_glCreateShader(GLenum(GL_VERTEX_SHADER))

        vertexSource.withCString { stringPointer in
            withUnsafePointer(to: stringPointer) { arrayPointer in
                glad_glShaderSource(vertexShaderID, 1, arrayPointer, nil)
            }
        }

        glad_glCompileShader(vertexShaderID)

        var success: Int32 = 0
        glad_glGetShaderiv(vertexShaderID, GLenum(GL_COMPILE_STATUS), &success)

        if success == GL_FALSE {
            var logLength: Int32 = 0
            glad_glGetShaderiv(vertexShaderID, GLenum(GL_INFO_LOG_LENGTH), &logLength)

            let infoLog = String(cString: [Int8](unsafeUninitializedCapacity: Int(logLength + 1)) { buffer, initializedCount in
                glad_glGetShaderInfoLog(vertexShaderID, logLength, nil, buffer.baseAddress)
                buffer[Int(logLength)] = 0
                initializedCount = Int(logLength + 1)
            })

            glad_glDeleteShader(vertexShaderID)

            Log.coreError("Compilation of vertex shader failed: \(infoLog)")

            return nil
        }


        let fragmentShaderID = glad_glCreateShader(GLenum(GL_FRAGMENT_SHADER))

        fragmentSource.withCString { stringPointer in
            withUnsafePointer(to: stringPointer) { arrayPointer in
                glad_glShaderSource(fragmentShaderID, 1, arrayPointer, nil)
            }
        }

        glad_glCompileShader(fragmentShaderID)

        glad_glGetShaderiv(fragmentShaderID, GLenum(GL_COMPILE_STATUS), &success)

        if success == GL_FALSE {
            var logLength: Int32 = 0
            glad_glGetShaderiv(fragmentShaderID, GLenum(GL_INFO_LOG_LENGTH), &logLength)

            let infoLog = String(cString: [Int8](unsafeUninitializedCapacity: Int(logLength + 1)) { buffer, initializedCount in
                glad_glGetShaderInfoLog(fragmentShaderID, logLength, nil, buffer.baseAddress)
                buffer[Int(logLength)] = 0
                initializedCount = Int(logLength + 1)
            })

            glad_glDeleteShader(vertexShaderID)
            glad_glDeleteShader(fragmentShaderID)

            Log.coreError("Compilation of fragment shader failed: \(infoLog)")

            return nil
        }


        let id = glad_glCreateProgram()
        glad_glAttachShader(id, vertexShaderID)
        glad_glAttachShader(id, fragmentShaderID)
        glad_glLinkProgram(id)

        glad_glGetProgramiv(id, GLenum(GL_LINK_STATUS), &success)

        if success == GL_FALSE {
            var logLength: Int32 = 0
            glad_glGetProgramiv(id, GLenum(GL_INFO_LOG_LENGTH), &logLength)

            let infoLog = String(cString: [Int8](unsafeUninitializedCapacity: Int(logLength + 1)) { buffer, initializedCount in
                glad_glGetProgramInfoLog(id, logLength, nil, buffer.baseAddress)
                buffer[Int(logLength)] = 0
                initializedCount = Int(logLength + 1)
            })

            glad_glDeleteProgram(id)
            glad_glDeleteShader(vertexShaderID)
            glad_glDeleteShader(fragmentShaderID)

            Log.coreError("Linking of program failed: \(infoLog)")

            return nil
        }

        glad_glDetachShader(id, vertexShaderID)
        glad_glDetachShader(id, fragmentShaderID)

        glad_glDeleteShader(vertexShaderID)
        glad_glDeleteShader(fragmentShaderID)

        self.id = id
    }

    public func bind() {
        glad_glUseProgram(id)
    }

    public func unbind() {
        glad_glUseProgram(0)
    }
}
