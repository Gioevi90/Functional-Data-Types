import XCTest
@testable import Data_Types

class OptionTests: XCTestCase {
    func testOptionMap() {
        let result = Option.some(42).map(f: { $0 * 2 })
        XCTAssertEqual(result, .some(84))
    }

    func testOptionFMap() {
        let result = Option.some("42").flatMap(f: toInt)
        XCTAssertEqual(result, .some(42))
    }

    func testOptionNoneMap() {
        let result = Option.none.map(f: { $0 * 2 })
        XCTAssertEqual(result, .none)
    }

    func testOptionNoneFMap() {
        let result = Option.none.flatMap(f: toInt)
        XCTAssertEqual(result, .none)
    }

    func testOptionFoldSome() {
        let result = Option.some(42).fold(f: { 0 }, g: { $0 * 2 })
        XCTAssertEqual(result, 84)
    }

    func testOptionFoldNone() {
        let result = Option.none.fold(f: { 0 }, g: { $0 * 2 })
        XCTAssertEqual(result, 0)
    }
}

extension OptionTests {
    func toInt(_ input: String) -> Option<Int> {
        guard let value = Int(input) else {
            return Option.none
        }
        return Option.some(value)
    }
}
