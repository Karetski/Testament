public struct Casting<Type> {
    private let instance: Any
    private let isCustomMessageApplied: Bool

    public enum Error: Swift.Error {
        case unableToCast(instance: Any, to: Type.Type)
    }

    init(_ instance: Any, isCustomMessageApplied: Bool = false) {
        self.instance = instance
        self.isCustomMessageApplied = isCustomMessageApplied
    }

    public func make(file: StaticString = #file, line: UInt = #line) throws -> Type {
        guard let castedInstance = instance as? Type else {
            Assertion.fail(
                message: "Unable to cast instance to type \(Type.self)",
                executionLocation: ExecutionLocation(file: file, line: line)
            ).generate(
                precondition: !isCustomMessageApplied
            )
            throw Error.unableToCast(instance: instance, to: Type.self)
        }
        return castedInstance
    }
}

class Test {
}
