import Foundation

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
        
        
    }
}
