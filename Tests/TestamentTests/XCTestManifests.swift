import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CastingTests.allTests),
        testCase(UnwrappingTests.allTests)
    ]
}
#endif
