import Foundation

enum Validated<Left, Right> {
    case notValid(value: Left)
    case valid(value: Right)

    func map<V>(f: (Right) -> V) -> Validated<Left, V> {
        switch self {
        case let .notValid(value):
            return .notValid(value: value)
        case let .valid(value):
            return Validated<Left, V>.valid(value: f(value))
        }
    }

    func fold<V>(f: (Left) -> V, g: (Right) -> V) -> V {
        switch self {
        case let .notValid(value: value):
            return f(value)
        case let .valid(value: value):
            return g(value)
        }
    }
}

extension Validated where Left: Semigroup {
    func apply<V>(other: Validated<Left, (Right) -> V>) -> Validated<Left, V> {
        return fold(f: { left in other.fold(f: { .notValid(value: left.combine($0)) },
                                     g: { _ in .notValid(value: left) }) },
             g: { right in other.fold(f: { .notValid(value: $0) },
                                      g: { .valid(value: $0(right)) }) })
    }
}

extension Validated: Equatable where Left: Equatable, Right: Equatable {
    static func == (lhs: Validated<Left, Right>, rhs: Validated<Left, Right>) -> Bool {
        switch (lhs, rhs) {
        case let (.valid(value: value), .valid(value: value2)):
            return value == value2
        case let (.notValid(value: value), .notValid(value: value2)):
            return value2 == value
        default:
            return false
        }
    }
}
