import Foundation
import UIKit

struct AppFontName {
    static let regular = "Roboto-Regular"
    static let bold = "Roboto-Bold"
}

extension UIFont {
    static func defaultFont(size: CGFloat = 16) -> UIFont? {
        return UIFont(name: AppFontName.regular, size: size)
    }
}

