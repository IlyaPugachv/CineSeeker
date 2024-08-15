import UIKit

extension UITextField {

    func configureTextField(
        placeholder: String? = nil,
        font: UIFont = .systemFont(ofSize: 14),
        returnKeyType: UIReturnKeyType = .default,
        delegate: UITextFieldDelegate? = nil,
        icon: UIImage? = nil,
        iconColor: UIColor = .black,
        backgroundColor: UIColor = .white,
        placeholderColor: UIColor = .lightGray,
        textColor: UIColor = .black,
        cornerRadius: CGFloat = 8,
        padding: CGFloat = 10,
        textAlignment: NSTextAlignment = .left,
        leftViewPadding: CGFloat = 10
    ) {
        self.placeholder = placeholder
        self.font = font
        self.returnKeyType = returnKeyType
        self.delegate = delegate
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.textAlignment = textAlignment
        self.textColor = textColor
        
        if let icon = icon {
            let iconView = UIImageView(frame: CGRect(
                x: leftViewPadding,
                y: 5, width: 20,
                height: 20))
            
            iconView.image = icon.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = iconColor
            iconView.contentMode = .scaleAspectFit
            
            let iconContainerView = UIView(frame: CGRect(
                x: 0,
                y: 0,
                width: 30 + leftViewPadding,
                height: 30))
            
            iconContainerView.addSubview(iconView)
            self.leftView = iconContainerView
            
        } else {
            let paddingView = UIView(frame: CGRect(
                x: 0,
                y: 0,
                width: padding,
                height: frame.height))
            
            self.leftView = paddingView
        }
        self.leftViewMode = .always
        
        self.attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [.foregroundColor: placeholderColor]
        )
        
        addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
    }
    
    @objc
    private func textFieldDidBeginEditing() {
        showCancelButton()
    }
    
    private func showCancelButton() {
        guard let superview = self.superview else { return }

        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Отмена", for: .normal)
        cancelButton.setTitleColor(.Colors.Font.lightGray, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        cancelButton.tag = 1001

        superview.addView(cancelButton)

        NSLayoutConstraint.activate([
            cancelButton.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -16),
            cancelButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cancelButton.heightAnchor.constraint(equalTo: self.heightAnchor),
            cancelButton.widthAnchor.constraint(equalToConstant: 75)
        ])
        
        self.frame.size.width -= 75
        
        cancelButton.isHidden = false
        
        addTarget(self, action: #selector(textFieldTextChanged), for: .editingChanged)
    }
    
    @objc 
    private func cancelButtonPressed() {
        self.text = ""
        
        self.resignFirstResponder()
        
        hideCancelButton()
    }

    private func hideCancelButton() {
        guard let superview = self.superview else { return }

        if let cancelButton = superview.viewWithTag(1001) {
            self.frame.size.width += 75
            
            cancelButton.isHidden = true
            
            cancelButton.removeFromSuperview()
        }
        
        removeTarget(self, action: #selector(textFieldTextChanged), for: .editingChanged)
    }

    @objc 
    private func textFieldTextChanged() {
        guard let superview = self.superview,
              let cancelButton = superview.viewWithTag(1001) else { return }

        cancelButton.isHidden = self.text?.isEmpty ?? true
    }
}

