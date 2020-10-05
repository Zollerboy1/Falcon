//
//  BufferLayout.swift
//  Falcon
//
//  Created by Josef Zoller on 03.10.20.
//

public struct BufferLayout {
    public struct Element {
        public let type: ShaderType
        public let name: String
        public let size: Int
        public let offset: Int
        public let isNormalized: Bool
    }

    @_functionBuilder
    public enum Builder {
        /// The type of individual statement expressions in the transformed function,
        /// which defaults to Component if buildExpression() is not provided.
        public typealias Expression = ShaderPrimitive

        /// The type of a partial result, which will be carried through all of the
        /// build methods.
        public typealias Component = [ShaderPrimitive]

        /// The type of the final returned result.
        public typealias FinalResult = (elements: [Element], stride: Int)

        /// If declared, provides contextual type information for statement
        /// expressions to translate them into partial results.
        public static func buildExpression(_ expression: Expression) -> Component {
            [expression]
        }

        /// Required by every result builder to build combined results from
        /// statement blocks.
        public static func buildBlock(_ firstChild: Component, _ children: Component...) -> Component {
            firstChild + children.flatMap { $0 }
        }

        /// Optimization for building a single-component block.
        public static func buildBlock(_ component: Component) -> Component {
            component
        }

        /// Enables support for `if` statements that do not have an `else`.
        public static func buildOptional(_ children: Component?) -> Component {
            children ?? []
        }

        /// With buildEither(second:), enables support for 'if-else' and 'switch'
        /// statements by folding conditional results into a single result.
        public static func buildEither(first child: Component) -> Component {
            child
        }

        /// With buildEither(first:), enables support for 'if-else' and 'switch'
          /// statements by folding conditional results into a single result.
        public static func buildEither(second child: Component) -> Component {
            child
        }

        /// This will be called on the partial result from the outermost
        /// block statement to produce the final returned result.
        public static func buildFinalResult(_ component: Component) -> FinalResult {
            var offset = 0

            return (component.map({ primitive in
                let size = primitive.type.size
                let element = Element(type: primitive.type, name: primitive.name, size: size, offset: offset, isNormalized: primitive.isNormalized)

                offset += size

                return element
            }), offset)
        }
    }

    public typealias BuildFunction = () -> (elements: [Element], stride: Int)

    public let elements: [Element]
    public let stride: Int

    public init(@Builder buildElements: BuildFunction) {
        (self.elements, self.stride) = buildElements()
    }
}
