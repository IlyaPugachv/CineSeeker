import UIKit

extension Detail {
    class Presenter {
        
        // MARK: - Properties -
        
        weak var view: DetailView?
        var image: UIImage?
        
        // MARK: - Initializers
        
        init(image: UIImage?) {
            self.image = image
        }
        
        deinit {
            print(#function, self)
        }
        
        // MARK: - Methods -
        
    }
}

