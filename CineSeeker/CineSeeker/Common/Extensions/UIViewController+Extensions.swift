import UIKit

public protocol PresenterDelegate { }

public protocol ViewDelegate: AnyObject {
    var navigationController: UINavigationController? { get }
    func pushView()
    func navigate(to nextView: UIViewController, animated: Bool)
    func pop(animated: Bool)
}

public extension ViewDelegate {
    var navigationController: UINavigationController? { nil }
    func navigate(to nextView: UIViewController) {
        self.navigate(to: nextView, animated: true)
    }
}

extension UIViewController {
    public func pop(animated: Bool = true) {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: animated)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension UIViewController: ViewDelegate {
    func embeddedInNavigationController() -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: self)
        return navigationController
    }
    
    public func pushView() { }
    
    @objc public func navigate(to nextView: UIViewController, animated: Bool = true) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(nextView, animated: animated)
        }
    }
    
    @objc func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIViewController {
    
    func configureNavigationBar(withTitle title: String, backgroundColor: UIColor, titleColor: UIColor, rightBarButtonImage: UIImage?, rightBarButtonAction: Selector?) {
        let navBar = navigationController?.navigationBar
        navBar?.isTranslucent = false
        navBar?.tintColor = titleColor
        navBar?.titleTextAttributes = [.foregroundColor: titleColor]
        navigationItem.hidesBackButton = true
        
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = backgroundColor
            appearance.shadowColor = .clear
            appearance.titleTextAttributes = [.foregroundColor: titleColor]
            
            navBar?.standardAppearance = appearance
            navBar?.scrollEdgeAppearance = appearance
        } else {
            navBar?.barTintColor = backgroundColor
        }
        
        if let rightImage = rightBarButtonImage, let action = rightBarButtonAction {
            let rightButtonItem = UIBarButtonItem(image: rightImage, style: .plain, target: self, action: action)
            navigationItem.rightBarButtonItem = rightButtonItem
        }
        
        self.title = title
    }
}
