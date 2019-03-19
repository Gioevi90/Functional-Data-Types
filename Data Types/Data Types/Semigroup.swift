import Foundation

protocol Semigroup {
    func combine(_ other: Self) -> Self
}

extension Semigroup {
    func combine(a: Self, b: Self) -> Self {
        return a.combine(b)
    }
}

extension String: Semigroup {
    func combine(_ other: String) -> String {
        return self + other
    }
}

extension Array: Semigroup {
    func combine(_ other: Array<Element>) -> Array<Element> {
        return self + other
    }
}
