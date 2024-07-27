import UIKit

extension UILabel {
    func configureLabel(text: String, font: UIFont, color: UIColor, alignment: NSTextAlignment? = nil, numberOfLines: Int = 1) {
        self.text = text
        self.font = font
        self.textColor = color
        self.numberOfLines = numberOfLines
        
        if let alignment = alignment {
            self.textAlignment = alignment
        }
    }
}
