public struct Casting<Type> {
    private let instance: Any
    private let castingType: Type.Type
    private let isCustomMessageApplied: Bool

    public enum Error: Swift.Error {
        case failedCasting(Type.Type)
    }

    private struct FailureMessage: Message {
        var text: String {
            return "Failed to cast instance to type " + String(describing: Type.self)
        }
    }

    init(_ instance: Any, to castingType: Type.Type, isCustomMessageApplied: Bool = false) {
        self.instance = instance
        self.castingType = castingType
        self.isCustomMessageApplied = isCustomMessageApplied
    }

    public func make(file: StaticString = #file, line: UInt = #line) throws -> Type {
        if let castedInstance = instance as? Type {
            return castedInstance
        } else {
            if !isCustomMessageApplied {
                Generator.testFail(
                    message: FailureMessage(),
                    executionLocation: ExecutionLocation(file: file, line: line)
                )
            }
            throw Error.failedCasting(Type.self)
        }
    }
}
