import XCTest

protocol Message {
    var text: String { get }
}

struct ExecutionLocation {
    let file: StaticString
    let line: UInt

    static var empty: ExecutionLocation {
        return .init(file: "Unknown", line: 0)
    }
}

public struct Unwrapping<Type> {

    private let instance: Type?
    private let isCustomMessageApplied: Bool

    public enum Error: Swift.Error {
        case failedUnwrapping(Type.Type)
    }

    private struct FailureMessage: Message {
        var text: String {
            return "Failed to unwrap instance of " + String(describing: Type.self)
        }
    }

    public init(_ instance: Type?, isCustomMessageApplied: Bool = false) {
        self.instance = instance
        self.isCustomMessageApplied = isCustomMessageApplied
    }

    public func make(file: StaticString = #file, line: UInt = #line) throws -> Type {
        if let instance = instance {
            return instance
        } else {
            if !isCustomMessageApplied {
                testFail(
                    message: FailureMessage(),
                    executionLocation: ExecutionLocation(file: file, line: line)
                )
            }
            throw Error.failedUnwrapping(Type.self)
        }
    }
}

func testFail(message: Message, executionLocation: ExecutionLocation) {
    XCTFail(message.text, file: executionLocation.file, line: executionLocation.line)
}
