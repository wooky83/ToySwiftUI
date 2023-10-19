@testable import FeatureSupport
import XCTest

final class FeatureSupportTests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()

    }

    func testMethod() {
        XCTAssertTrue(true)
    }

    func compareColor(color1: UIColor, color2: UIColor) {
        var red1: CGFloat = 0, green1: CGFloat = 0, blue1: CGFloat = 0, alpha1: CGFloat = 0
        var red2: CGFloat = 0, green2: CGFloat = 0, blue2: CGFloat = 0, alpha2: CGFloat = 0

        color1.getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)
        color2.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)

        XCTAssertEqual(red1, red2, accuracy: 0.001)
        XCTAssertEqual(green1, green2, accuracy: 0.001)
        XCTAssertEqual(blue1, blue2, accuracy: 0.001)
        XCTAssertEqual(alpha1, alpha2, accuracy: 0.001)
    }

    func testUniqueOrangeColor() {
        compareColor(
            color1: Style.Color.uniqueOrange.value,
            color2: UIColor(red: 1.0, green: 0.494, blue: 0.294, alpha: 1.0)
        )
    }

    func testUniquePinkColor() {
        compareColor(
            color1: Style.Color.uniquePink.value,
            color2: UIColor(red: 1.0, green: 0.427, blue: 0.757, alpha: 1.0)
        )
    }

    func testUniquePurpleColor() {
        compareColor(
            color1: Style.Color.uniquePurple.value,
            color2: UIColor(red: 0.565, green: 0.376, blue: 0.937, alpha: 1.0)
        )
    }
}
