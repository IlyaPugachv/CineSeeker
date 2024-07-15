import Foundation

extension WatchList {
    class Presenter {
        
        // MARK: - Properties -
        
        weak var view: WatchListView?
        
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

