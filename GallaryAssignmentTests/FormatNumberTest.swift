
import XCTest
@testable import GallaryAssignment

class FormatNumberTest: XCTestCase {

    func testFormatNumberBelow1000ShouldReturnSameValue() {
        let likeCount = "123"
        let likeCountFormat = likeCount.toCurrencyFormat()
        XCTAssertEqual(likeCountFormat, "123")
    }
    
    func testFormatNumberOver1000ShouldReturnComma() {
        let likeCount = "1234"
        let likeCountFormat = likeCount.toCurrencyFormat()
        XCTAssertEqual(likeCountFormat, "1,234")
    }
    
    func testFormatNumberErrorNullValueShouldReturnEmptyString() {
        let likeCount = "null"
        let likeCountFormat = likeCount.toCurrencyFormat()
        XCTAssertEqual(likeCountFormat, "")
    }
    
    func testFormatNumberEmptyStringShouldReturnEmptyString() {
        let likeCount = " "
        let likeCountFormat = likeCount.toCurrencyFormat()
        XCTAssertEqual(likeCountFormat, "")
    }
    
    func testFormatNumberMoreThan6DigitsShouldReturn2Comma() {
        let likeCount = "123456789"
        let likeCountFormat = likeCount.toCurrencyFormat()
        XCTAssertEqual(likeCountFormat, "123,456,789")
    }

    func testFormatNumberLessthanZeroShouldReturnEmptyString() {
        let likeCount = "-123456789"
        let likeCountFormat = likeCount.toCurrencyFormat()
        XCTAssertEqual(likeCountFormat, "")
    }
}

