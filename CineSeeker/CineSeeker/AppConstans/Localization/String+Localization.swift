import Foundation

extension String {
    struct Localization {
        
        //MARK: - HOME -
        static var home: String { localise("home") }
        static var search: String { localise("search") }
        static var watchList: String { localise("watchList") }

    }
}


public func localise(_ key: String) -> String {
    let value = NSLocalizedString(key, comment: "")
    if value != key || NSLocale.preferredLanguages.first == "en" {
        return value
    }

    // Fall back to en
    guard
        let path = Bundle.main.path(forResource: "en", ofType: "lproj"),
        let bundle = Bundle(path: path)
        else { return value }
    return NSLocalizedString(key, bundle: bundle, comment: "")
}

