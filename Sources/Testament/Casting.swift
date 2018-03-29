public enum CastingError: Swift.Error {
    case unableToCast(instance: Any, type: Any.Type)
}

public struct Casting<Type> {
    private let instance: Any
    private let isCustomAssertionApplied: Bool

    init(_ instance: Any, isCustomAssertionApplied: Bool = false) {
        self.instance = instance
        self.isCustomAssertionApplied = isCustomAssertionApplied
    }

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
