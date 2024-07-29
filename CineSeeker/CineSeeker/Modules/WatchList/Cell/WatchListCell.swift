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
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .lightGray
        return label
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        label.numberOfLines = 0
        return label
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
        
        textStackView.addArrangedSubview(filmNameLabel)
        textStackView.addArrangedSubview(ratingLabel)
        textStackView.addArrangedSubview(genreLabel)
        textStackView.addArrangedSubview(releaseDateLabel)
        textStackView.addArrangedSubview(movieLengthLabel)
        
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
            
            textStackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            textStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            textStackView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            
            filmNameLabel.topAnchor.constraint(equalTo: textStackView.topAnchor),
            ratingLabel.topAnchor.constraint(equalTo: filmNameLabel.bottomAnchor, constant: 5),
            genreLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 5),
            releaseDateLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 5),
            movieLengthLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 5)
            
            
            
            
        ])
    }
}


