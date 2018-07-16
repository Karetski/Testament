public enum UnwrappingError: Swift.Error {
    case unableToUnwrap(type: Any.Type)
}

/// Structure that represents test of unwrapping instance of `Type` with resulting unwrapped value.
public struct Unwrapping<Type> {
    private let instance: Type?
    private let isCustomAssertionApplied: Bool

    /// Instantiates unwrapping of `instance`.
    ///
    /// - Parameters:
    ///   - instance: Instance to be unwrapped.
    ///   - isCustomAssertionApplied: Flag that indicates need of custom test assertion. You shouldn't use it, generally.
    public init(_ instance: Type?, isCustomAssertionApplied: Bool = false) {
        self.instance = instance
        self.isCustomAssertionApplied = isCustomAssertionApplied
    }

    /// Tries to unwrap `instance` of `Type` if possible. Otherwise, throws an error.
    ///
    /// - Parameters:
    ///   - file: File, where this function has been executed.
    ///   - line: Line in file, where this function has been executed.
    /// - Returns: Unwrapped value of `Type`.
    /// - Throws: `UnwrappingError.unableToUnwrap` if unwrapping is unavailable.
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
