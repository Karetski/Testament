import XCTest

struct Generator {
    static func testFail(message: Message, executionLocation: ExecutionLocation) {
        XCTFail(message.text, file: executionLocation.file, line: executionLocation.line)
    }
}
