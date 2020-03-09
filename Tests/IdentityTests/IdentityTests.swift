/**
 *  Identity
 *  Copyright (c) John Sundell 2019
 *  Licensed under the MIT license (see LICENSE file)
 */

import XCTest
import Identity

final class IdentityTests: XCTestCase {
    func testStringBasedIdentifier() {
        struct Model: Identifiable {
            let id: ID
        }

        let model = Model(id: "Hello, world!")
        XCTAssertEqual(model.id, "Hello, world!")
    }

    func testIntBasedIdentifier() {
        struct Model: Identifiable {
            typealias RawIdentifier = Int
            let id: ID
        }

        let model = Model(id: 7)
        XCTAssertEqual(model.id, 7)
    }

    func testCodableIdentifier() throws {
        struct Model: Identifiable, Codable {
            typealias RawIdentifier = UUID
            let id: ID
        }

        let model = Model(id: Identifier(rawValue: UUID()))
        let data = try JSONEncoder().encode(model)
        let decoded = try JSONDecoder().decode(Model.self, from: data)
        XCTAssertEqual(model.id, decoded.id)
    }

    func testIdentifierEncodedAsSingleValue() throws {
        struct Model: Identifiable, Codable {
            let id: ID
        }

        let model = Model(id: "I'm an ID")
        let data = try JSONEncoder().encode(model)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        XCTAssertEqual(json?["id"] as? String, "I'm an ID")
    }

    func testExpressingIdentifierUsingStringInterpolation() {
        struct Model: Identifiable {
            let id: ID
        }

        let model = Model(id: "Hello, world!")
        XCTAssertEqual(model.id, "Hello, \("world!")")
    }

    func testIdentifierDescription() {
        struct StringModel: Identifiable {
            let id: ID
        }

        struct IntModel: Identifiable {
            typealias RawIdentifier = Int
            let id: ID
        }

        let stringID: StringModel.ID = "An ID"
        let intID: IntModel.ID = 7

        XCTAssertEqual(stringID.description, "An ID")
        XCTAssertEqual(intID.description, "7")
    }

    func testIdentifierHashValue() {
        struct FirstModel: Identifiable {
            let id: ID
        }

        struct SecondModel: Identifiable {
            let id: ID
        }

        let first = FirstModel(id: "0")
        let second = SecondModel(id: "0")

        XCTAssertNotEqual(first.id.hashValue, second.id.hashValue)
    }

    func testAllTestsRunOnLinux() {
        verifyAllTestsRunOnLinux()
    }
}

extension IdentityTests: LinuxTestable {
    static var allTests = [
        ("testStringBasedIdentifier", testStringBasedIdentifier),
        ("testIntBasedIdentifier", testIntBasedIdentifier),
        ("testCodableIdentifier", testCodableIdentifier),
        ("testIdentifierEncodedAsSingleValue", testIdentifierEncodedAsSingleValue),
        ("testExpressingIdentifierUsingStringInterpolation", testExpressingIdentifierUsingStringInterpolation),
        ("testIdentifierDescription", testIdentifierDescription),
        ("testIdentifierHashValue", testIdentifierHashValue),
    ]
}
