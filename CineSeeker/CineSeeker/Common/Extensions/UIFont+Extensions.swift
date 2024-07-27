import UIKit

extension UIFont {
    
    static func interRegular(of size: CGFloat) -> UIFont {
        return UIFont(name: "inter-Regular", size: size) ?? .systemFont(ofSize: size, weight: .regular)
    }
    
    static func interMedium(of size: CGFloat) -> UIFont {
        return UIFont(name: "inter-Medium", size: size) ?? .systemFont(ofSize: size, weight: .medium)
    }
    
    static func interSemibold(of size: CGFloat) -> UIFont {
        return UIFont(name: "inter-Semibold", size: size) ?? .systemFont(ofSize: size, weight: .semibold)
    }
    
    static func interBold(of size: CGFloat) -> UIFont {
       return UIFont(name: "inter-Bold", size: size) ?? .systemFont(ofSize: size, weight: .bold)
    }
}
