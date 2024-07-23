import UIKit

extension UIImageView {
    func configureImage(named imageName: String, tintColor: UIColor? = nil) {
        self.image = UIImage(named: imageName)
        if let tintColor = tintColor {
            self.tintColor = tintColor
            self.image = self.image?.withRenderingMode(.alwaysTemplate)
        } else {
            self.image = self.image?.withRenderingMode(.alwaysOriginal)
        }
    }
}
