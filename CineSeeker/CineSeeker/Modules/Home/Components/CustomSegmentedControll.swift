import UIKit

protocol CustomSegmentedControlDelegate: AnyObject {
    func change(to index: Int)
}

class CustomSegmentedControl: UIView {
    
    var buttonTitles: [String]!
    var buttons: [UIButton]!
    var selectorView: UIView!
    
    var textColor: UIColor = .white
    var selectorViewColor: UIColor = .Colors.Font.lightGray
    var selectorTextColor: UIColor = .white
    
    weak var delegate: CustomSegmentedControlDelegate?
    
    public private(set) var selectedIndex: Int = 0
    
    convenience init(frame: CGRect, buttonTitle: [String]) {
        self.init(frame: frame)
        self.buttonTitles = buttonTitle
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
    }
    
    func setButtonTitles(buttonTitles: [String]) {
        self.buttonTitles = buttonTitles
        self.updateView()
    }
    
    func setIndex(index: Int) {
        buttons.forEach { $0.setTitleColor(textColor, for: .normal) }
        
        let button = buttons[index]
        selectedIndex = index
        button.setTitleColor(selectorTextColor, for: .normal)
        button.titleLabel?.font = UIFont.interSemibold(of: 10)
        
        let selectorPosition = (frame.width / CGFloat(buttonTitles.count)) * CGFloat(index) + (frame.width / CGFloat(buttonTitles.count) - selectorWidth) / 2
        UIView.animate(withDuration: 0.2) {
            self.selectorView.frame.origin.x = selectorPosition
        }
    }
    
    @objc
    func buttonAction(sender: UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            btn.titleLabel?.font = UIFont.interRegular(of: 10)
            
            if btn == sender {
                let selectorPosition = (frame.width / CGFloat(buttonTitles.count)) * CGFloat(buttonIndex) + (frame.width / CGFloat(buttonTitles.count) - selectorWidth) / 2
                
                selectedIndex = buttonIndex
                delegate?.change(to: selectedIndex)
                
                UIView.animate(
                    withDuration: 0.3
                ) { self.selectorView.frame.origin.x = selectorPosition }
                
                btn.setTitleColor(selectorTextColor, for: .normal)
                btn.titleLabel?.font = UIFont.interMedium(of: 14)
            }
        }
    }
}

extension CustomSegmentedControl {
    
    private var selectorWidth: CGFloat {
        frame.width / CGFloat(buttonTitles.count) * 0.8
    }
    
    private var selectorHeight: CGFloat { 4.0 }
    
    private func updateView() {
        createButtons()
        configSelectorView()
        configStackView()
    }
    
    private func configStackView() {
        
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        addView(stack)
        
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -selectorHeight - 10).isActive = true
        stack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    private func configSelectorView() {
        
        let initialSelectorPosition = (
            frame.width / CGFloat(buttonTitles.count) - selectorWidth) / 2
        
        selectorView = UIView(
            frame: CGRect(
                x: initialSelectorPosition,
                y: self.frame.height - selectorHeight,
                width: selectorWidth,
                height: selectorHeight
            )
        )
        
        selectorView.backgroundColor = selectorViewColor
        addView(selectorView)
    }
    
    private func createButtons() {
        
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach { $0.removeFromSuperview() }
        
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.addTarget(self, action: #selector(CustomSegmentedControl.buttonAction(sender:)), for: .touchUpInside)
            button.setTitleColor(textColor, for: .normal)
            button.titleLabel?.font = UIFont.interMedium(of: 8)
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        buttons[0].titleLabel?.font = UIFont.interSemibold(of: 10)
    }
}

