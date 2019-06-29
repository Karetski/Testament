public enum ThrowingError: Swift.Error {
    case unableToThrowAny(expressionResultType: Any.Type)

    case unableToThrow(errorType: Swift.Error.Type, expressionResultType: Any.Type)
    case unexpectedError(expectedErrorType: Swift.Error.Type, expressionResultType: Any.Type)

    case unableToInvokeErrorless(expectedResultType: Any.Type)
}

/// Asserts that `expression` throws an error and returns an instance of error being thrown. Generates failure when expression is invoked without errors.
/// - Parameter expression: Expression to be checked.
/// - Parameter message: An optional description of the failure. If not provided uses default generated failure message. To silence the failure set to `nil`.
/// - Parameter file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
/// - Parameter line: The line number on which failure occurred. Defaults to the line number on which this function was called.
/// - Returns: Error being thrown.
/// - Throws: `ThrowingError.unableToThrowAny` if expression is invoked without errors.
@discardableResult
public func assertThrowsAny<Throwing>(
    _ expression: @autoclosure () throws -> Throwing,
    message: String? = "expected expression with result \(Throwing.self) to throw any error",
    file: StaticString = #file,
    line: UInt = #line
) throws -> Error {
    do {
        _ = try expression()
        failIfNeeded(message, file: file, line: line)
    } catch {
        return error
    }

    throw ThrowingError.unableToThrowAny(expressionResultType: Throwing.self)
}

/// Asserts that `expression` throws an error of type `Error` and returns an instance of error being thrown. Generates failure when expression is invoked without errors.
/// - Parameter expression: Expression to be checked.
/// - Parameter type: Type of expected error.
/// - Parameter message: An optional description of the failure. If not provided uses default generated failure message. To silence the failure set to `nil`.
/// - Parameter file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
/// - Parameter line: The line number on which failure occurred. Defaults to the line number on which this function was called.
/// - Returns: Error being thrown.
/// - Throws: `ThrowingError.unableToThrow` if expression is invoked without errors or `ThrowingError.unexpectedError` if error type is other than expected.
@discardableResult
public func assertThrows<Throwing, Error: Swift.Error>(
    _ expression: @autoclosure () throws -> Throwing,
    with: Error.Type,
    message: String? = "expected expression with result \(Throwing.self) to throw \(Error.self)",
    file: StaticString = #file,
    line: UInt = #line
) throws -> Error {
    do {
        _ = try expression()
        failIfNeeded(message, file: file, line: line)
    } catch let expectedError as Error {
        return expectedError
    } catch {
        failIfNeeded(message, file: file, line: line)
        throw ThrowingError.unexpectedError(
            expectedErrorType: Error.self,
            expressionResultType: Throwing.self
        )
    }

    throw ThrowingError.unableToThrow(
        errorType: Error.self,
        expressionResultType: Throwing.self
    )
}

/// Asserts that `expression` invokes without error and returns a resulting value. Generates failure when expression is invoked with error.
/// - Parameter expression: Expression to be checked.
/// - Parameter message: An optional description of the failure. If not provided uses default generated failure message. To silence the failure set to `nil`.
/// - Parameter file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
/// - Parameter line: The line number on which failure occurred. Defaults to the line number on which this function was called.
/// - Returns: Resulting value of the `expression`.
/// - Throws: `ThrowingError.unableToInvokeErrorless` if expression is invoked with error.
@discardableResult
func assertErrorless<Expectation>(
    _ expression: @autoclosure () throws -> Expectation,
    message: String? = "expected expression with result \(Expectation.self) to be errorless",
    file: StaticString = #file,
    line: UInt = #line
) throws -> Expectation {
    do {
        return try expression()
    } catch {
        failIfNeeded(message, file: file, line: line)
        throw ThrowingError.unableToInvokeErrorless(expectedResultType: Expectation.self)
    }
}

