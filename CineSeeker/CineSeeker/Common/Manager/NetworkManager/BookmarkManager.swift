import Foundation
import RealmSwift

class BookmarkManager {
    static let shared = BookmarkManager()
    let realm = try! Realm()

    func addBookmark(movie: BookmarkedMovieModel) {
        try! realm.write {
            realm.add(movie, update: .all)
        }
    }

    func removeBookmark(movieTitle: String) {
        if let movie = realm.objects(BookmarkedMovieModel.self).filter("title == %@", movieTitle).first {
            try! realm.write {
                realm.delete(movie)
            }
        }
    }

    func isBookmarked(movieTitle: String) -> Bool {
        return realm.objects(BookmarkedMovieModel.self).filter("title == %@", movieTitle).first != nil
    }

    func getBookmarkedMovies() -> Results<BookmarkedMovieModel> {
        return realm.objects(BookmarkedMovieModel.self)
    }
}
