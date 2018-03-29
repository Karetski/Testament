public enum UnwrappingError: Swift.Error {
    case unableToUnwrap(type: Any.Type)
}

public struct Unwrapping<Type> {
    private let instance: Type?
    private let isCustomAssertionApplied: Bool

    public init(_ instance: Type?, isCustomAssertionApplied: Bool = false) {
        self.instance = instance
        self.isCustomAssertionApplied = isCustomAssertionApplied
    }

    public func make(file: StaticString = #file, line: UInt = #line) throws -> Type {
        guard let unwrappedInstance = instance else {
            Assertion.fail(
                message: "Unable to unwrap instance of \(Type.self)",
                executionLocation: ExecutionLocation(file: file, line: line)
            ).generate(
                precondition: !isCustomAssertionApplied
            )
            throw UnwrappingError.unableToUnwrap(type: Type.self)
        }
        return unwrappedInstance
    }
}
