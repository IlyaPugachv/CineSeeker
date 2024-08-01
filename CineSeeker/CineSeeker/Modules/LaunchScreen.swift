import UIKit

final class LaunchScreen: UIViewController {
    
    // MARK: - Subviews -
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        imageView.configureImage(
            named: "imageLaunchScreen")
        
        return imageView
    }()
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Setup -
    
    private func setupView() {
        view.backgroundColor = .Colors.Font.darkGray
        view.addView(logoImageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 189),
            logoImageView.heightAnchor.constraint(equalToConstant: 189)
        ])
    }
}
