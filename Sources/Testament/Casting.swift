public enum CastingError: Swift.Error {
    case unableToCast(instance: Any, type: Any.Type)
}

/// Structure that represents test of casting instance to `Type` with resulting casted value.
public struct Casting<Type> {
    private let instance: Any
    private let isCustomAssertionApplied: Bool

    /// Instantiates casting of `instance` to `Type`.
    ///
    /// - Parameters:
    ///   - instance: Instance to be casted.
    ///   - isCustomAssertionApplied: Flag that indicates need of custom test assertion. You shouldn't use it, generally.
    public init(_ instance: Any, isCustomAssertionApplied: Bool = false) {
        self.instance = instance
        self.isCustomAssertionApplied = isCustomAssertionApplied
    }

    /// Tries to cast `instance` to `Type` if possible. Otherwise, throws an error.
    ///
    /// - Parameters:
    ///   - file: File, where this function has been executed.
    ///   - line: Line in file, where this function has been executed.
    /// - Returns: Casted value of `Type`.
    /// - Throws: `CastingError.unableToCast` if type casting is unavailable.
    public func make(file: StaticString = #file, line: UInt = #line) throws -> Type {
        guard let castedInstance = instance as? Type else {
            Assertion.fail(
                message: "Unable to cast instance to type \(Type.self)",
                executionLocation: ExecutionLocation(file: file, line: line)
            ).generate(
                precondition: !isCustomAssertionApplied
            )
            throw CastingError.unableToCast(instance: instance, type: Type.self)
        }
        return castedInstance
    }
}
