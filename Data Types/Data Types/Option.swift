import Foundation

enum Option<T> {
    case some(_ value: T)
    case none

    func map<V>(f: (T) -> V) -> Option<V> {
        switch self {
        case let .some(value):
            return Option<V>.some(f(value))
        case .none:
            return Option<V>.none
        }
    }

    func flatMap<V>(f: (T) -> Option<V>) -> Option<V> {
        switch self {
        case let .some(value):
            return f(value)
        case .none:
            return Option<V>.none
        }
    }

    func fold<V>(f: () -> V, g: (T) -> V) -> V {
        switch self {
        case .none:
            return f()
        case let .some(value):
            return g(value)
        }
    }
}

extension Option: Equatable where T: Equatable {
    static func == (lhs: Option<T>, rhs: Option<T>) -> Bool {
        switch (lhs, rhs) {
        case let (.some(value), .some(value2)):
            return value == value2
        case (.none, .none):
            return true
        default:
            return false
        }
    }
}
