import XCTest

@testable import Testament

private enum Stubs {
    struct AnyError: Swift.Error { }
    struct AnyOtherError: Swift.Error { }

    static func returnValue() throws -> Int {
        return 0
    }

    static func throwAny() throws -> Int {
        throw AnyError()
    }

    static func throwAnyOther() throws -> Int {
        throw AnyOtherError()
    }
}

class ThrowingTests: XCTestCase {
    static var allTests = [
        ("testThrowingAny", testThrowingAny),
        ("testThrowingAnyComplex", testThrowingAnyComplex),
        ("testThrowing", testThrowing),
        ("testThrowingComplex", testThrowingComplex),
        ("testErrorless", testErrorless),
        ("testErrorlessComplex", testErrorlessComplex)
    ]

    func testThrowingAny() throws {
        let error = try assertThrowsAny(try Stubs.throwAny())
        XCTAssertTrue(error is Stubs.AnyError)
    }

    func testThrowingAnyComplex() {
        do {
            let error = try assertThrowsAny(try Stubs.throwAny())
            XCTAssertTrue(error is Stubs.AnyError)
        } catch ThrowingError.unableToThrowAny(let type) {
            XCTFail("Error of \(type) must not be thrown")
        } catch {
            XCTFail("Unexpected error")
        }

        do {
            try assertThrowsAny(try Stubs.returnValue(), message: nil)
            XCTFail("Error must be already thrown")
        } catch ThrowingError.unableToThrowAny(let type) {
            XCTAssertTrue(type == Int.self)
        } catch {
            XCTFail("Unexpected error")
        }
    }

    func testThrowing() throws {
        try assertThrows(Stubs.throwAny(), with: Stubs.AnyError.self)
    }

    func testThrowingComplex() {
        do {
            try assertThrows(Stubs.throwAny(), with: Stubs.AnyError.self)
        } catch {
            XCTFail("There shouldn't be any errors")
        }

        do {
            try assertThrows(Stubs.returnValue(), with: Stubs.AnyError.self, message: nil)
            XCTFail("Error must be already thrown")
        } catch ThrowingError.unableToThrow(let expectedErrorType, let expressionResultType) {
            XCTAssertTrue(expectedErrorType == Stubs.AnyError.self)
            XCTAssertTrue(expressionResultType == Int.self)
        } catch {
            XCTFail("Unexpected error")
        }

        do {
            try assertThrows(Stubs.throwAnyOther(), with: Stubs.AnyError.self, message: nil)
            XCTFail("Error must be already thrown")
        } catch ThrowingError.unexpectedError(let expectedErrorType, let expressionResultType) {
            XCTAssertTrue(expectedErrorType == Stubs.AnyError.self)
            XCTAssertTrue(expressionResultType == Int.self)
        } catch {
            XCTFail("Unexpected error")
        }
    }

    func testErrorless() throws {
        let int = try assertErrorless(Stubs.returnValue())
        XCTAssertTrue(int == 0)
    }

    func testErrorlessComplex() {
        do {
            let int = try assertErrorless(Stubs.returnValue())
            XCTAssertTrue(int == 0)
        } catch {
            XCTFail("There shouldn't be any errors")
        }

        do {
            try assertErrorless(Stubs.throwAny(), message: nil)
            XCTFail("Error must be already thrown")
        } catch ThrowingError.unableToInvokeErrorless(let expectedResultType) {
            XCTAssertTrue(expectedResultType == Int.self)
        } catch {
            XCTFail("Unexpected error")
        }
    }
}

