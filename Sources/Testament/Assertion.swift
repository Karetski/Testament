import XCTest

struct ExecutionLocation {
    let file: StaticString
    let line: UInt

    static var empty: ExecutionLocation {
        return .init(file: "Unknown", line: 0)
    }
}

typealias Message = String

enum Assertion {
    case fail(message: Message, executionLocation: ExecutionLocation)

    func generate(precondition: Bool = true) {
        guard precondition else {
            return
        }

        switch self {
        case .fail(let message, let executionLocation):
            XCTFail(message, file: executionLocation.file, line: executionLocation.line)
        }
    }
}
