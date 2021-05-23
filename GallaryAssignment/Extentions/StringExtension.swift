import UIKit

extension String {
    func htmlToAttributedString(truncatingTail: Bool = false, fontSize: CGFloat) -> NSAttributedString? {
        let htmlString = self
        let data = htmlString.data(using: String.Encoding.unicode)!
        let attrStr = try? NSAttributedString(
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil)
        let newFont = UIFontMetrics.default.scaledFont(for: UIFont.defaultFont(size: fontSize)!)
        
        let mattrStr = NSMutableAttributedString(attributedString: attrStr!)
        if truncatingTail {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = .byTruncatingTail
            let range = NSRange(location: 0, length: mattrStr.mutableString.length)
            mattrStr.addAttribute(NSAttributedString.Key.paragraphStyle,
                                  value: paragraphStyle,
                                  range: range)
        }
        mattrStr.beginEditing()
        mattrStr.enumerateAttribute(.font, in: NSRange(location: 0, length: mattrStr.length), options: .longestEffectiveRangeNotRequired) { (value, range, _) in
            if let oFont = value as? UIFont, let newFontDescriptor = oFont.fontDescriptor.withFamily(newFont.familyName).withSymbolicTraits(oFont.fontDescriptor.symbolicTraits) {
                
                let nFont = UIFont(descriptor: newFontDescriptor, size: oFont.pointSize)
                mattrStr.removeAttribute(.font, range: range)
                mattrStr.addAttribute(.font, value: nFont, range: range)
            }
        }
        mattrStr.endEditing()
        if let lastCharacter = mattrStr.string.last, lastCharacter == "\n" {
            mattrStr.deleteCharacters(in: NSRange(location: mattrStr.length - 1, length: 1))
        }
        return mattrStr
    }
    
    func toCurrencyFormat() -> String {
        if self == "" {
            return "0"
        }
        guard let str = Double(self) else {
            return "0"
        }

        if str < 0 {
            return "0"
        }
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "US_us")
        let myNumber = NSNumber(value: str)
        formatter.numberStyle = .currencyAccounting
        guard var currency = formatter.string(from: myNumber) else {
            return self
        }

        currency.replace(originalString: "$", withString: "")
        currency.replace(originalString: "(", withString: "")
        currency.replace(originalString: ")", withString: "")

        if currency.contains(".") {
            let strCurrency = currency.split(separator: ".")
            return String(strCurrency[0])
        }
        return currency
    }
    
    mutating func replace(originalString: String, withString newString: String) {
        let replacedString = self.replacingOccurrences(of: originalString, with: newString)
        self = replacedString
    }
}
