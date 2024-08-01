import UIKit

final class LaunchScreen: UIViewController {
    
    // MARK: - Subviews -
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.configureImage(named: "imageLaunchScreen")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Setup -
    
    private func setupView() {
        view.backgroundColor = UIColor(red: 0.12, green: 0.14, blue: 0.18, alpha: 1.00)
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
