import UIKit

extension Detail {
    class Presenter {
        
        // MARK: - Properties -
        
        weak var view: DetailView?
        
        var image: UIImage?
        var title: String
        var rating: Double
        
        // MARK: - Initializers
        
        init(image: UIImage?, title: String, rating: Double) {
            self.image = image
            self.title = title
            self.rating = rating
        }
        
        deinit {
            print(#function, self)
        }
        
        // MARK: - Methods -
        
    }
}

