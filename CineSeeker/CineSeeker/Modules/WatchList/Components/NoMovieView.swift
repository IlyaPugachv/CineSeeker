import UIKit

final class NoMovieView: UIView {
    
    private let boxImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let headerNoMovieLabel: UILabel = {
        let label = UILabel()
        label.font = .interSemibold(of: 16)
        label.textColor = .white
        return label
    }()
    
    private let findYourMovieLabel: UILabel = {
        let label = UILabel()
        label.font = .interMedium(of: 12)
        label.textColor = .Colors.Font.lightGray
        label.numberOfLines = 0
        return label
    }()
    
    // Public properties to set image and text
    var image: UIImage? {
        didSet {
            boxImageView.image = image
        }
    }
    
    var headerText: String? {
        didSet {
            headerNoMovieLabel.text = headerText
        }
    }
    
    var findYourMovieText: String? {
        didSet {
            findYourMovieLabel.text = findYourMovieText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(boxImageView)
        addSubview(headerNoMovieLabel)
        addSubview(findYourMovieLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        boxImageView.translatesAutoresizingMaskIntoConstraints = false
        headerNoMovieLabel.translatesAutoresizingMaskIntoConstraints = false
        findYourMovieLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            boxImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            boxImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            boxImageView.widthAnchor.constraint(equalToConstant: 76),
            boxImageView.heightAnchor.constraint(equalToConstant: 76),
            
            headerNoMovieLabel.topAnchor.constraint(equalTo: boxImageView.bottomAnchor, constant: 15),
            headerNoMovieLabel.centerXAnchor.constraint(equalTo: boxImageView.centerXAnchor),
            
            findYourMovieLabel.topAnchor.constraint(equalTo: headerNoMovieLabel.bottomAnchor, constant: 15),
            findYourMovieLabel.centerXAnchor.constraint(equalTo: headerNoMovieLabel.centerXAnchor),
            findYourMovieLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.8)
        ])
    }
}
