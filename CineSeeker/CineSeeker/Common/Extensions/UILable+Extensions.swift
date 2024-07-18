import UIKit

extension UILabel {
  
    func configureLabel(text: String, font: UIFont, color: UIColor, alignment: NSTextAlignment? = nil) {
        self.text = text
        self.font = font
        self.textColor = color
        
        if let alignment = alignment {
            self.textAlignment = alignment
        }
    }
}
