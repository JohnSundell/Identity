/**
 *  Identity
 *  Copyright (c) John Sundell 2019
 *  Licensed under the MIT license (see LICENSE file)
 */

import Foundation

// MARK: - Core API

/// Protocol used to mark a given type as being identifiable, meaning
/// that it has a type-safe identifier, backed by a raw value, which
/// defaults to String.
public protocol Identifiable {
    /// The backing raw type of this type's identifier.
    associatedtype RawIdentifier = String
    /// The ID of this instance.
    var id: Identifier<Self> { get }
}

/// A type-safe identifier for a given `Value`, backed by a raw value.
/// When backed by a `Codable` type, `Identifier` also becomes codable,
/// and will be encoded into a single value according to its raw value.
public struct Identifier<Value: Identifiable> {
    /// The raw value that is backing this identifier.
    public let rawValue: Value.RawIdentifier

    /// Initialize an instance with a raw value.
    public init(rawValue: Value.RawIdentifier) {
        self.rawValue = rawValue
    }
}

// MARK: - Integer literal support

extension Identifier: ExpressibleByIntegerLiteral
          where Value.RawIdentifier: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Value.RawIdentifier.IntegerLiteralType) {
        rawValue = .init(integerLiteral: value)
    }
}

// MARK: - String literal support

extension Identifier: ExpressibleByUnicodeScalarLiteral
          where Value.RawIdentifier: ExpressibleByUnicodeScalarLiteral {
    public init(unicodeScalarLiteral value: Value.RawIdentifier.UnicodeScalarLiteralType) {
        rawValue = .init(unicodeScalarLiteral: value)
    }
}

extension Identifier: ExpressibleByExtendedGraphemeClusterLiteral
          where Value.RawIdentifier: ExpressibleByExtendedGraphemeClusterLiteral {
    public init(extendedGraphemeClusterLiteral value: Value.RawIdentifier.ExtendedGraphemeClusterLiteralType) {
        rawValue = .init(extendedGraphemeClusterLiteral: value)
    }
}

extension Identifier: ExpressibleByStringLiteral
          where Value.RawIdentifier: ExpressibleByStringLiteral {
    public init(stringLiteral value: Value.RawIdentifier.StringLiteralType) {
        rawValue = .init(stringLiteral: value)
    }
}

// MARK: - Compiler-generated protocol support

extension Identifier: Equatable where Value.RawIdentifier: Equatable {}
extension Identifier: Hashable where Value.RawIdentifier: Hashable {}

// MARK: - Codable support

extension Identifier: Codable where Value.RawIdentifier: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        rawValue = try container.decode(Value.RawIdentifier.self)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}
