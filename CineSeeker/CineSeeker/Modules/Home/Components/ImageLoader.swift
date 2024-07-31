import UIKit
import Kingfisher

final class ImageLoader {
    
    static func loadImage(into imageView: UIImageView, from urlString: String?, placeholder: UIImage?, activityIndicator: UIActivityIndicatorView) {
        activityIndicator.startAnimating()
        imageView.image = nil
        
        guard let urlString = urlString, let url = URL(string: urlString) else {
            activityIndicator.stopAnimating()
            imageView.image = placeholder
            return
        }
        
        imageView.kf.setImage(with: url) { result in
            activityIndicator.stopAnimating()
            switch result {
            case .success:
                break
            case .failure:
                imageView.image = placeholder
            }
        }
    }
}

