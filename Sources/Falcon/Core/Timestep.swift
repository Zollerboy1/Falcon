//
//  Timestep.swift
//  Falcon
//
//  Created by Josef Zoller on 05.10.20.
//

public struct Timestep {
    private let time: Double

    public init(time: Double = 0) {
        self.time = time
    }

    public var seconds: Float { Float(time) }
    public var milliseconds: Float { Float(time * 1000) }


    public static func +(lhs: Timestep, rhs: Timestep) -> Timestep {
        return Timestep(time: lhs.time + rhs.time)
    }

    public static func +<T>(lhs: Timestep, rhs: T) -> T where T: BinaryFloatingPoint {
        return T(lhs.time) + rhs
    }

    public static func +<T>(lhs: T, rhs: Timestep) -> T where T: BinaryFloatingPoint {
        return lhs + T(rhs.time)
    }


    public static func -(lhs: Timestep, rhs: Timestep) -> Timestep {
        return Timestep(time: lhs.time - rhs.time)
    }

    public static func -<T>(lhs: Timestep, rhs: T) -> T where T: BinaryFloatingPoint {
        return T(lhs.time) - rhs
    }

    public static func -<T>(lhs: T, rhs: Timestep) -> T where T: BinaryFloatingPoint {
        return lhs - T(rhs.time)
    }


    public static func *(lhs: Timestep, rhs: Timestep) -> Timestep {
        return Timestep(time: lhs.time * rhs.time)
    }

    public static func *<T>(lhs: Timestep, rhs: T) -> T where T: BinaryFloatingPoint {
        return T(lhs.time) * rhs
    }

    public static func *<T>(lhs: T, rhs: Timestep) -> T where T: BinaryFloatingPoint {
        return lhs * T(rhs.time)
    }


    public static func /(lhs: Timestep, rhs: Timestep) -> Timestep {
        return Timestep(time: lhs.time / rhs.time)
    }

    public static func /<T>(lhs: Timestep, rhs: T) -> T where T: BinaryFloatingPoint {
        return T(lhs.time) / rhs
    }

    public static func /<T>(lhs: T, rhs: Timestep) -> T where T: BinaryFloatingPoint {
        return lhs / T(rhs.time)
    }
}
