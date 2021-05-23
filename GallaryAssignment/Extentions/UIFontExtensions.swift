import Foundation
import UIKit

struct AppFontName {
    static let regular = "Roboto-Regular"
    static let bold = "Roboto-Bold"
}

extension UIFont {
    enum FontName {
        case regular
        case bold
    }
    
    static func defaultFont(size: CGFloat = 16, isBold: Bool = false) -> UIFont? {
        if isBold == false {
            return UIFont(name: AppFontName.regular, size: size)
        }
        return UIFont(name: AppFontName.bold, size: size)
    }
}

