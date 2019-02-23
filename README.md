# Testament

Testament is a microframework that gives you convenient constructions to write correct unit tests for optionals and casting types in Swift programming language.

## Installation

#### CocoaPods

Testament is available via CocoaPods.
```
pod 'Testament', :git => 'https://github.com/Karetski/Testament.git'
```

#### Swift Package Manager

If you use Swift Package Manager, simply add Testament as a dependency of your package in `Package.swift`:
```
.package(url: "https://github.com/Karetski/Testament.git", from: "1.0.0")
```
#### Carthage

If you want to use Testament via Carthage please follow [the link.](https://fuller.li/posts/using-swift-package-manager-with-carthage/)

## Motivation

There is a problem when we, developers, writing tests for optionals in Swift. This problem is widely described [here.](https://www.natashatherobot.com/unit-testing-optionals-in-swift-xctassertnotnil/) 

The main point of this framework is to transform the following construction:
```
if let string = optionalString {
    XCTAssert(string == "Testament")
} else {
    XCTFail("Shouldn't be nil")
}
```
Into readable and useful:
```
let string = try Unwrapping(optionalString).make()
XCTAssert(string == "Testament")
```
It also works with type casting:
```
let int: Int = try Casting(anyInt).make()
XCTAssert(int == 1337)
```

## License

Testament is licensed under the Apache License 2.0. See [LICENSE.md](https://github.com/Karetski/Snowonder/blob/master/LICENSE.md).
