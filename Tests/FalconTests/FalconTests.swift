import XCTest
@testable import Falcon

final class FalconTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Falcon().text, "Welcome to the Falcon Game Engine!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
