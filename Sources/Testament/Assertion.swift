import XCTest

enum Assertion {
    case fail(message: Message, executionLocation: ExecutionLocation)

    func generate(precondition: Bool = true) {
        guard precondition else {
            return
        }

        switch self {
        case .fail(let message, let executionLocation):
            XCTFail(message.text, file: executionLocation.file, line: executionLocation.line)
        }
    }
}
