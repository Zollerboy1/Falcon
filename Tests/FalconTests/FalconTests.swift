import XCTest
@testable import Falcon

final class FalconTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Falcon.welcomeMessage, "Welcome to the Falcon Game Engine!")
    }
    
    func testEventDispatcher() {
        let event = MouseMovedEvent(x: 25, y: 20)
        let dispatcher = EventDispatcher(event: event)
        
        dispatcher.dispatch { (event: MouseScrolledEvent) in
            return true
        }
        
        XCTAssertFalse(event.isHandled)
        
        dispatcher.dispatch { (event: MouseMovedEvent) in
            XCTAssertEqual(event.x, 25)
            return true
        }
        
        XCTAssertTrue(event.isHandled)
    }

    static var allTests = [
        ("testExample", testExample),
        ("testEventDispatcher", testEventDispatcher)
    ]
}
