import XCTest
@testable import Data_Types

class EitherTests: XCTestCase {
    func testEitherMapRight() {
        let result = Either<String, Int>.right(42).map(f: { $0 * 2 })
        XCTAssertEqual(result, .right(84))
    }

    func testEitherFMapRight() {
        let result = Either.right("42").flatMap(f: toInt)
        XCTAssertEqual(result, .right(42))
    }

    func testEitherMapLeft() {
        let result = Either<String, Int>.left("error").map(f: { $0 * 2 })
        XCTAssertEqual(result, .left("error"))
    }

    func testEitherFMapLeft() {
        let result = Either.left("error").flatMap(f: toInt)
        XCTAssertEqual(result, .left("error"))
    }

    func testFoldRight() {
        let result = Either<String, Int>.right(42).fold(f: { _ in 0 }, g: { $0 * 2 })
        XCTAssertEqual(84, result)
    }

    func testFoldLeft() {
        let result = Either.left("error").fold(f: { _ in 0 }, g: { $0 * 2 })
        XCTAssertEqual(0, result)
    }
}

extension EitherTests {
    func toInt(_ input: String) -> Either<String, Int> {
        guard let value = Int(input) else {
            return Either.left("string in input is not an integer")
        }
        return Either.right(value)
    }
}
