import Foundation

extension String {
    struct Localization {
        
        //MARK: - AUXILIARY -
        static var minutes: String { localise("minutes")}
        
        //MARK: - ERROR -
        static var errorGettingTheMovieName: String { localise("errorGettingTheMovieName")}
        static var errorWhenGettingTheMovieDescription: String { localise("errorWhenGettingTheMovieDescription")}
     
        //MARK: - HOME -
        static var home: String { localise("home") }
        static var search: String { localise("search") }
        static var watchList: String { localise("watchList") }
        static var whatDoYouWanToWatch: String { localise("whatDoYouWanToWatch") }
        static var nowPlaying: String { localise("nowPlaying") }
        static var upComing: String { localise("upComing") }
        static var topRated: String { localise("topRated") }
        static var popular: String { localise("popular") }
          
        //MARK: - DETAIL CELL-
        static var detail: String { localise("detail") }
        
        //MARK: - Watch List -
        static var thereIsNoMovieYet: String { localise("thereIsNoMovieYet") }
        static var findYourMovie: String { localise("findYourMovie") }
    }
}

public func localise(_ key: String) -> String {
    let value = NSLocalizedString(key, comment: "")
    if value != key || NSLocale.preferredLanguages.first == "en" {
        return value
    }

    guard
        let path = Bundle.main.path(forResource: "en", ofType: "lproj"),
        let bundle = Bundle(path: path)
        else { return value }
    return NSLocalizedString(key, bundle: bundle, comment: "")
}

