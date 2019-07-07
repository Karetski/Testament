# Testament

Testament is a microframework that gives you convenient constructions to write correct unit tests for optionals and casting types in Swift programming language.

## Installation


#### Swift Package Manager

If you use Swift Package Manager, simply add Testament as a dependency of your package in `Package.swift`:
```
.package(url: "https://github.com/Karetski/Testament.git", .upToNextMajor(from: "2.0.0"))
```

#### CocoaPods

Testament is available via CocoaPods.
```
pod 'Testament', :git => 'https://github.com/Karetski/Testament.git'
```

#### Carthage

If you want to use Testament via Carthage please follow [the link.](https://fuller.li/posts/using-swift-package-manager-with-carthage/)

## Motivation

There is a problem when we, developers, writing tests for optionals in Swift. This problem is widely described [here.](https://www.natashatherobot.com/unit-testing-optionals-in-swift-xctassertnotnil/) 

The main point of this tool is to transform the following construction:
```
if let string = optionalString {
    XCTAssert(string == "Testament")
} else {
    XCTFail("Shouldn't be nil")
}
```
Into readable and useful:
```
let string = try assertUnwraps(optionalString)
XCTAssert(string == "Testament")
```
*Note that your test case needs to be marked with `throws` if it uses Testament operators*

## Should you use it?

In Xcode 11 Apple added `XCTUnwrap` that uses quite the same approach for unwrapping, so for the most cases it should be enough, and you don't really need Testament.

On the other hand is that Testament has better semantical meaning with support of `assertCasts`, `assertThrows`, `assertThrowsAny` and `assertErrorless` in addition to `assertUnwraps` with fully descriptive failure reasons. So if you're interested in described operators or don't support Xcode 11 yet, then Testament is a great tool for you.

## License

Testament is licensed under the Apache License 2.0. See [LICENSE.md](https://github.com/Karetski/Snowonder/blob/master/LICENSE.md).
