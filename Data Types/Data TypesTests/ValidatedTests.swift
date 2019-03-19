import XCTest
@testable import Data_Types

class ValidatedTests: XCTestCase {
    func testValidatedMapValid() {
        let result = Validated<String, Int>.valid(value: 42).map(f: { $0 * 2 })
        XCTAssertEqual(result, .valid(value: 84))
    }

    func testValidatedMapInvalid() {
        let result = Validated<String, Int>.notValid(value: "error").map(f: { $0 * 2 })
        XCTAssertEqual(result, .notValid(value: "error"))
    }

    func testFoldValid() {
        let result = Validated<String, Int>.valid(value: 42).fold(f: { _ in 0 }, g: { $0 * 2 })
        XCTAssertEqual(result, 84)
    }

    func testFoldInvalid() {
        let result = Validated<String, Int>.notValid(value: "error").fold(f: { _ in 0 }, g: { $0 * 2 })
        XCTAssertEqual(result, 0)
    }

    func testApplyBothValid() {
        let first: Validated<[String], Int> = Validated.valid(value: 42)
        let second: Validated<[String], (Int) -> Int> = Validated.valid(value: { $0 * 2 })

        let result = first.apply(other: second)
        XCTAssertEqual(result, .valid(value: 84))
    }

    func testApplyFirstError() {
        let first: Validated<[String], Int> = Validated.notValid(value: ["first error"])
        let second: Validated<[String], (Int) -> Int> = Validated.valid(value: { $0 * 2 })

        let result = first.apply(other: second)
        XCTAssertEqual(result, .notValid(value: ["first error"]))
    }

    func testApplySecondError() {
        let first: Validated<[String], Int> = Validated.valid(value: 42)
        let second: Validated<[String], (Int) -> Int> = Validated.notValid(value: ["second error"])

        let result = first.apply(other: second)
        XCTAssertEqual(result, .notValid(value: ["second error"]))
    }

    func testApplyBothError() {
        let first: Validated<[String], Int> = Validated.notValid(value: ["first error"])
        let second: Validated<[String], (Int) -> Int> = Validated.notValid(value: ["second error"])

        let result = first.apply(other: second)
        XCTAssertEqual(result, .notValid(value: ["first error", "second error"]))
    }
}
