import UIKit

final class ReviewsCell: UICollectionViewCell {
    
    static let reuseId = "ReviewsCell"
    
     let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 22
        return imageView
    }()
    
     let usernameLabel: UILabel = {
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
    
     let commentLabel: UILabel = {
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
        contentView.addView(ratingLabel)
        
        textStackView.addArrangedSubview(usernameLabel)
        textStackView.addArrangedSubview(commentLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
           
            profileImageView.widthAnchor.constraint(equalToConstant: 44),
            profileImageView.heightAnchor.constraint(equalToConstant: 44),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            textStackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
            textStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            textStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            ratingLabel.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor, constant: 13),
            ratingLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 4),
            ratingLabel.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor),
            ratingLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with profileImage: UIImage, username: String, rating: String, comment: String) {
        profileImageView.image = profileImage
        usernameLabel.text = username
        ratingLabel.text = rating
        commentLabel.text = comment
    }
}

