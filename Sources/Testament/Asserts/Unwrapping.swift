public enum UnwrappingError: Swift.Error {
    case unableToUnwrap(type: Any.Type)
}

/// Asserts that an expression is not `nil`, and returns its unwrapped value. Generates a failure when `instance == nil`.
/// - Parameter instance: Instance to be unwrapped.
/// - Parameter message: An optional description of the failure. If not provided uses default generated failure message. To silence the failure set to `nil`.
/// - Parameter file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
/// - Parameter line: The line number on which failure occurred. Defaults to the line number on which this function was called.
/// - Returns: A value of type `Unwrapping`.
/// - Throws: `UnwrappingError.unableToUnwrap` if unwrapping is unavailable.
@discardableResult
public func assertUnwraps<Unwrapping>(
    _ instance: Unwrapping?,
    message: String? = "expected \(Unwrapping.self) to be not nil",
    file: StaticString = #file,
    line: UInt = #line
) throws -> Unwrapping {
    guard let unwrapped = instance else {
        failIfNeeded(message, file: file, line: line)
        throw UnwrappingError.unableToUnwrap(type: Unwrapping.self)
    }
    return unwrapped
}
