import XCTest
@testable import GallaryAssignment

class ConvertHtmlStringTest: XCTestCase {
    func testWhenReceivePlainTextShouldReturnPlainText() {
        let plainText = "AAAA"
        let htmlText = plainText.htmlToAttributedString(fontSize: 12)
        XCTAssertEqual(htmlText?.string ?? "", plainText)
    }
    
    func testWhenReceiveHTMLTextShouldReturnPlainText() {
        let plainText = "celand, you're in Iceland! Can you believe it? \rNo, every time I can't."
        let htmlText = plainText.htmlToAttributedString(fontSize: 12)
        let resultText = "celand, you're in Iceland! Can you believe it? No, every time I can't."
        XCTAssertEqual(htmlText?.string ?? "", resultText)
    }
    
    func testWhenReceiveHTMLParagraphShouldReturnPlainText() {
        let plainText = "Gracias a mi primo Carmelo Larrabide Por iniciarme en este tipo de fotografía y dejarme su equipo, Gracias Maestro.\n\nThanks to my cousin Carmelo Larrabide for initiating me in this type of photography and leaving me his equipment, Thank you Master."
        let htmlText = plainText.htmlToAttributedString(fontSize: 12)
        let resultText = "Gracias a mi primo Carmelo Larrabide Por iniciarme en este tipo de fotografía y dejarme su equipo, Gracias Maestro. Thanks to my cousin Carmelo Larrabide for initiating me in this type of photography and leaving me his equipment, Thank you Master."
        XCTAssertEqual(htmlText?.string ?? "", resultText)
    }

}
