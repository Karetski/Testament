public struct Unwrapping<Type> {
    private let instance: Type?
    private let isCustomMessageApplied: Bool

    public enum Error: Swift.Error {
        case unableToUnwrap(instance: Type?)
    }

    public init(_ instance: Type?, isCustomMessageApplied: Bool = false) {
        self.instance = instance
        self.isCustomMessageApplied = isCustomMessageApplied
    }

    public func make(file: StaticString = #file, line: UInt = #line) throws -> Type {
        guard let unwrappedInstance = instance else {
            Assertion.fail(
                message: "Unable to unwrap instance of \(Type.self)",
                executionLocation: ExecutionLocation(file: file, line: line)
            ).generate(
                precondition: !isCustomMessageApplied
            )
            throw Error.unableToUnwrap(instance: instance)
        }
        return unwrappedInstance
    }
}
