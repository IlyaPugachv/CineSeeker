import UIKit
import SDWebImage
import Kingfisher

final class ActorCell: UICollectionViewCell {
    
    static let reuseId = "ActorCell"
    
     let actorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    let actorNameLabel: UILabel = {
       let label = UILabel()
       label.font = .systemFont(ofSize: 14, weight: .bold)
       label.textColor = .white
       return label
   }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addView(actorImageView)
        contentView.addView(actorNameLabel)
        
        NSLayoutConstraint.activate([
            actorImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            actorImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            actorImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            actorImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            actorImageView.heightAnchor.constraint(equalToConstant: 100),
            actorImageView.widthAnchor.constraint(equalToConstant: 100)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func configure(with movie: Actor) {
//        
//        if let posterUrlString = movie.poster?.url, let posterUrl = URL(string: posterUrlString) {
//            posterImageView.kf.setImage(with: posterUrl)
//        }
//    }
}

