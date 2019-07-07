import XCTest

func failIfNeeded(_ message: String?, file: StaticString, line: UInt) {
    guard let message = message else {
        return
    }

    XCTFail(message, file: file, line: line)
}
