# 🆔 Identity

Welcome to **Identity**, a small library that makes it easy to create *type-safe identifiers* in Swift. Identifiers are often core to how models and other values are referenced within a code base, so leveraging the compiler to ensure that they're used in a correct manner can go a long way to making the model layer of an app or system more robust.

For more information, check out *["Type-safe identifiers in Swift"](https://www.swiftbysundell.com/posts/type-safe-identifiers-in-swift)* on Swift by Sundell.

## Making types identifiable

All you have to do to use Identity is to make a model conform to `Identifiable`, and give it an `id` property, like this:

```swift
struct User: Identifiable {
    let id: Identifier<User>
    let name: String
}
```

And just like that, the above `User` identifier is now type-safe!

## Customizing the raw type

`Identifier` values are backed by strings by default, but that can easily be customized by giving an `Identifiable` type a `RawIdentifier`:

```swift
struct Article: Identifiable {
    typealias RawIdentifier = UUID

    let id: Identifier<Article>
    let title: String
}
```

The above `Article` identifier is now backed by a `UUID` instead of a `String`.

## Conveniences built-in

Even though Identity is focused on type safety, it still offers several conveniences to help reduce verbosity. For example, if an `Identifier` is backed by a raw value type that can be expressed by a `String` literal, so can the identifier:

```swift
let user = User(id: "johnsundell", name: "John Sundell")
```

The same is also true for identifiers that are backend by a raw value type that can be expressed by `Int` literals:

```swift
let tag = Tag(id: 7, name: "swift")
```

`Identifier` also becomes `Codable`, `Hashable` and `Equatable` whenever its raw value type conforms to one of those protocols.

## Type safety

So how exactly does Identity make identifiers more type-safe? First, when using Identity, it no longer becomes possible to accidentally pass an identifier for one type to an API that accepts an identifier for another type. For example, this code won't compile when using Identity:

```swift
articleManager.article(withID: user.id)
```

The compiler will give us an error above, since we're trying to pass an `Identifier<User>` value to a method that accepts an `Identifier<Article>` - giving us much stronger type safety than when using plain values, like `String` or `Int`, as identifiers.

Identity also makes it impossible to accidentially declare `id` properties of the wrong type. So the following won't compile either:

```swift
struct User: Identifiable {
    let id: Identifier<Article>
}
```

The reason the above code will fail to compile is because `Identifiable` requires types conforming to it to declare identifiers that are bound to the same type as the conformer, again providing an extra level of type safety.

## Installation

Since Identity is implemented within a single file, the easiest way to use it is to simply drag and drop it into your Xcode project.

But if you wish to use a dependency manager, you can use the [Swift Package Manager](https://github.com/apple/swift-package-manager) by declaring Identity as a dependency in your `Package.swift` file:

```swift
.package(url: "https://github.com/JohnSundell/Identity", from: "0.1.0")
```

*For more information, see [the Swift Package Manager documentation](https://github.com/apple/swift-package-manager/tree/master/Documentation).*

## Contributions & support

Identity is developed completely in the open, and your contributions are more than welcome.

Before you start using Identity in any of your projects, it’s highly recommended that you spend a few minutes familiarizing yourself with its documentation and internal implementation (it all fits [in a single file](https://github.com/JohnSundell/Identity/blob/master/Sources/Identity/Identity.swift)!), so that you’ll be ready to tackle any issues or edge cases that you might encounter.

To learn more about the principles used to implement Identity, check out *["Type-safe identifiers in Swift"](https://www.swiftbysundell.com/posts/type-safe-identifiers-in-swift)* on Swift by Sundell.

This project does not come with GitHub Issues-based support, and users are instead encouraged to become active participants in its continued development — by fixing any bugs that they encounter, or improving the documentation wherever it’s found to be lacking.

If you wish to make a change, [open a Pull Request](https://github.com/JohnSundell/Identity/pull/new) — even if it just contains a draft of the changes you’re planning, or a test that reproduces an issue — and we can discuss it further from there.

Hope you’ll enjoy using **Identity**! 😀
