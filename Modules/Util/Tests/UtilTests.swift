import Collections
@testable import Util
import XCTest

final class UtilTests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testOrderedSet() {
        let oSet: OrderedSet<Int> = [4, 2, 1, 3, 5]
        XCTAssertEqual(oSet.sorted(), [1, 2, 3, 4, 5])
    }
}
