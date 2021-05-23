
import XCTest
@testable import GallaryAssignment

class FormatNumberTest: XCTestCase {

    func testWhenCallFormatNumberBelow1000ShouldReturnSameValue() {
        let likeCount = "123"
        let likeCountFormat = likeCount.toCurrencyFormat()
        XCTAssertEqual(likeCountFormat, "123")
    }
    
    func testWhenCallFormatNumberOver1000ShouldReturnComma() {
        let likeCount = "1234"
        let likeCountFormat = likeCount.toCurrencyFormat()
        XCTAssertEqual(likeCountFormat, "1,234")
    }
    
    func testWhenCallFormatNumberErrorNullValueShouldReturnEmptyString() {
        let likeCount = "null"
        let likeCountFormat = likeCount.toCurrencyFormat()
        XCTAssertEqual(likeCountFormat, "")
    }
    
    func testWhenCallFormatNumberEmptyStringShouldReturnEmptyString() {
        let likeCount = " "
        let likeCountFormat = likeCount.toCurrencyFormat()
        XCTAssertEqual(likeCountFormat, "")
    }
    
    func testWhenCallFormatNumberMoreThan6DigitsShouldReturn2Comma() {
        let likeCount = "123456789"
        let likeCountFormat = likeCount.toCurrencyFormat()
        XCTAssertEqual(likeCountFormat, "123,456,789")
    }

    func testWhenCallFormatNumberLessthanZeroShouldReturnEmptyString() {
        let likeCount = "-123456789"
        let likeCountFormat = likeCount.toCurrencyFormat()
        XCTAssertEqual(likeCountFormat, "")
    }
}

