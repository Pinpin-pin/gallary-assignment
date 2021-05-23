import UIKit

extension String {
    func htmlToAttributedString(truncatingTail: Bool = false) -> NSAttributedString? {
        let htmlString = self
        let data = htmlString.data(using: String.Encoding.unicode)!
        let attrStr = try? NSAttributedString(
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil)
        let newFont = UIFontMetrics.default.scaledFont(for: UIFont.defaultFont()!)
        
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
                
                var nFont = UIFont(descriptor: newFontDescriptor, size: oFont.pointSize)
                if oFont.pointSize < 16 {
                    nFont = UIFont(descriptor: newFontDescriptor, size: 16)
                }
                mattrStr.removeAttribute(.font, range: range)
                mattrStr.addAttribute(.font, value: nFont, range: range)
            }
        }
        mattrStr.endEditing()
        /// remove new line for the last character
        /// this usually happens when html has tag <p></p> which auto generates new line
        /// reference: https://stackoverflow.com/questions/37952687/how-to-remove-padding-under-last-paragraph-from-nsattributedstring-created-from
        if let lastCharacter = mattrStr.string.last, lastCharacter == "\n" {
            mattrStr.deleteCharacters(in: NSRange(location: mattrStr.length - 1, length: 1))
        }
        return mattrStr
    }
    
    func toCurrencyFormat() -> String {
        if self == "" {
            return self
        }
        guard let str = Double(self) else {
            return self
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
