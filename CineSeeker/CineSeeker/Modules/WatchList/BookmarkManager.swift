import Foundation
import RealmSwift

class BookmarkManager {
    static let shared = BookmarkManager()
    let realm = try! Realm()

    func addBookmark(movie: BookmarkedMovie) {
        try! realm.write {
            realm.add(movie, update: .all)
        }
    }

    func removeBookmark(movieTitle: String) {
        if let movie = realm.objects(BookmarkedMovie.self).filter("title == %@", movieTitle).first {
            try! realm.write {
                realm.delete(movie)
            }
        }
    }

    func isBookmarked(movieTitle: String) -> Bool {
        return realm.objects(BookmarkedMovie.self).filter("title == %@", movieTitle).first != nil
    }

    func getBookmarkedMovies() -> Results<BookmarkedMovie> {
        return realm.objects(BookmarkedMovie.self)
    }
}
