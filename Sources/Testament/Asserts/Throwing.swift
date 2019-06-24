public enum ThrowingError: Swift.Error {
    case unableToThrowAny(expressionResultType: Any.Type)

    case unableToThrow(errorType: Swift.Error.Type, expressionResultType: Any.Type)
    case unexpectedError(expectedErrorType: Swift.Error.Type, expressionResultType: Any.Type)
}

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
