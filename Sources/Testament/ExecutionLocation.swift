struct ExecutionLocation {
    let file: StaticString
    let line: UInt

    static var empty: ExecutionLocation {
        return .init(file: "Unknown", line: 0)
    }
}
