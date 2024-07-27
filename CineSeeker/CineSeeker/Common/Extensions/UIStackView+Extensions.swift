import UIKit

extension UIStackView {
    func configureStackView(axis: NSLayoutConstraint.Axis = .vertical,
                   spacing: CGFloat = 0,
                   alignment: UIStackView.Alignment = .fill,
                   distribution: UIStackView.Distribution = .fill,
                   isLayoutMarginsRelativeArrangement: Bool = false,
                   layoutMargins: UIEdgeInsets = .zero) {
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
        self.isLayoutMarginsRelativeArrangement = isLayoutMarginsRelativeArrangement
        self.layoutMargins = layoutMargins
    }
}
