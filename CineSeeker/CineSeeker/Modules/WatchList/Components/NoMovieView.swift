import UIKit

final class NoMovieView: UIView {
    
    private let boxImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        
        image.configureImage(
            named: "boxIcon")
        
        return image
    }()
    
    private let headerNoMovieLabel: UILabel = {
        let label = UILabel()
        
        label.configureLabel(
            text: .Localization.thereIsNoMovieYet,
            font: .interSemibold(of: 16),
            color: .white
        )
        
        return label
    }()
    
    private let findYourMovieLabel: UILabel = {
        let label = UILabel()
        
        label.configureLabel(
            text: .Localization.findYourMovie,
            font: .interMedium(of: 12),
            color: .Colors.Font.lightGray,
            numberOfLines: 0
        )
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addView(boxImageView)
        addView(headerNoMovieLabel)
        addView(findYourMovieLabel)
        
        setupConstrains()
    }
    
    private func setupConstrains() {
        
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
