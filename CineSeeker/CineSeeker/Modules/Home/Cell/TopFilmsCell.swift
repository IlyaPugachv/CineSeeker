import UIKit

final class TopFilmsCell: UICollectionViewCell {
    
    static let reuseId = "TopFilmsCVCell"
    
    private let topFilmsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .Colors.lightGray
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .Colors.gray
        layer.cornerRadius = 12
        
        addView(topFilmsImageView)
    }
}

extension TopFilmsCell {
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            topFilmsImageView.heightAnchor.constraint(equalToConstant: 200),
            topFilmsImageView.widthAnchor.constraint(equalToConstant: 110),
            topFilmsImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            topFilmsImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            topFilmsImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            topFilmsImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
          
        ])
    }
}

