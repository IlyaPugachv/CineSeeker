import UIKit
import SDWebImage
import Kingfisher

final class FullListFilmsCell: UICollectionViewCell {
    
    static let reuseId = "FullListFilmsCell"
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12

        return imageView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.color = .white
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addView(posterImageView)
        contentView.addView(activityIndicator)
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with movie: MovieRandom) {
       
        ImageLoader.loadImage(
            into: posterImageView,
            from: movie.poster?.url,
            placeholder: UIImage(named: "photoUser"),
            activityIndicator: activityIndicator)
    }
}

