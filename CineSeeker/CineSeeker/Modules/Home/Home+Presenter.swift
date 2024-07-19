import UIKit

extension Home {
    class Presenter {
        
        // MARK: - Properties -
        
        weak var view: HomeView?
        
        // MARK: - Initializers
        
        public init() {
            print(#function, self)
        }
        
        deinit {
            print(#function, self)
        }
        
        // MARK: - Methods -
        
        func showFilmDetail(image: UIImage?) {
            view?.navigate(to: Detail.View(with: .init(image: image)), animated: true)
        }
        
    }
}
