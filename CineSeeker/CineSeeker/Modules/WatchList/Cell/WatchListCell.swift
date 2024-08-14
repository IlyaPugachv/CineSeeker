import UIKit

final class WatchListCell: UICollectionViewCell {
    
    static let reuseId = "WatchListCell"
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 22
        return imageView
    }()
    
    let filmNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    let ratingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Star")
        imageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        return imageView
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .Colors.orange
        return label
    }()
    
    let genreImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Genre")
        imageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        return imageView
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let releaseDateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Calendar")
        imageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        return imageView
    }()
    
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let movieLengthImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Clock")
        imageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        return imageView
    }()
    
    let movieLengthLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addView(profileImageView)
        contentView.addView(textStackView)
        
        let ratingStackView = UIStackView(arrangedSubviews: [ratingImageView, ratingLabel])
        ratingStackView.spacing = 5
        
        let genreStackView = UIStackView(arrangedSubviews: [genreImageView, genreLabel])
        genreStackView.spacing = 5
        
        let releaseDateStackView = UIStackView(arrangedSubviews: [releaseDateImageView, releaseDateLabel])
        releaseDateStackView.spacing = 5
        
        let movieLengthStackView = UIStackView(arrangedSubviews: [movieLengthImageView, movieLengthLabel])
        movieLengthStackView.spacing = 5
        
        textStackView.addArrangedSubview(filmNameLabel)
        textStackView.addArrangedSubview(ratingStackView)
        textStackView.addArrangedSubview(genreStackView)
        textStackView.addArrangedSubview(releaseDateStackView)
        textStackView.addArrangedSubview(movieLengthStackView)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            profileImageView.widthAnchor.constraint(equalToConstant: 95),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
            
            textStackView.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            textStackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            textStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textStackView.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor)
        ])
    }
}
