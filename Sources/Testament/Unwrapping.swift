public struct Unwrapping<Type> {
    private let instance: Type?
    private let isCustomMessageApplied: Bool

    public enum Error: Swift.Error {
        case failedUnwrapping(Type?)
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
                Generator.testFail(
                    message: FailureMessage(),
                    executionLocation: ExecutionLocation(file: file, line: line)
                )
            }
            throw Error.failedUnwrapping(instance)
        }
    }
}
