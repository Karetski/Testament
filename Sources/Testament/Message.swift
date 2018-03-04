protocol Message {
    var text: String { get }
}

struct EmptyMessage: Message {
    var text: String {
        return ""
    }
}
