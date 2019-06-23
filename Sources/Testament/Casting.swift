public enum CastingError: Swift.Error {
    case unableToCast(instance: Any, type: Any.Type)
}

/// Asserts that instance casts to type `Casted`, and returns casted value. Generates failure when `Initial` isn't casted to `Casted`.
/// - Parameter instance: Instance to be casted.
/// - Parameter to: Type of expected instance. *Defines the returning type.*
/// - Parameter message: An optional description of the failure. If not provided uses default generated failure message. To silence the failure set to `nil`.
/// - Parameter file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
/// - Parameter line: The line number on which failure occurred. Defaults to the line number on which this function was called.
/// - Returns: A value of type `Casted`.
/// - Throws: `CastingError.unableToCast` if type casting is unavailable.
@discardableResult
public func assertCasts<Initial, Casted>(
    _ instance: Initial,
    to: Casted.Type,
    message: String? = "expected \(Initial.self) to be casted to \(Casted.self)",
    file: StaticString = #file,
    line: UInt = #line
) throws -> Casted {
    guard let casted = instance as? Casted else {
        failIfNeeded(message, file: file, line: line)
        throw CastingError.unableToCast(instance: instance, type: Casted.self)
    }
    return casted
}
