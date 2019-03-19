import Foundation

enum Either<Left, Right> {
    case left(_ value: Left)
    case right(_ value: Right)

    func map<V>(f: (Right) -> V) -> Either<Left, V> {
        switch self {
        case let .left(value):
            return .left(value)
        case let .right(value):
            return Either<Left, V>.right(f(value))
        }
    }

    func flatMap<V>(f: (Right) -> Either<Left, V>) -> Either<Left, V> {
        switch self {
        case let .left(value):
            return .left(value)
        case let .right(value):
            return f(value)
        }
    }

    func fold<V>(f: (Left) -> V, g: (Right) -> V) -> V {
        switch self {
        case let .left(value):
            return f(value)
        case let .right(value):
            return g(value)
        }
    }
}

extension Either: Equatable where Left: Equatable, Right: Equatable {
    static func == (lhs: Either<Left, Right>, rhs: Either<Left, Right>) -> Bool {
        switch (lhs, rhs) {
        case let (.left(value), .left(value2)):
            return value2 == value
        case let (.right(value), .right(value2)):
            return value2 == value
        default:
            return false
        }
    }
}
