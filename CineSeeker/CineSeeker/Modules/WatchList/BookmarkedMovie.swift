import Foundation
import RealmSwift

class BookmarkedMovie: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var title: String = ""
    @objc dynamic var posterImageData: Data? = nil
    @objc dynamic var rating: Double = 0.0
    @objc dynamic var genre: String = ""
    @objc dynamic var releaseDate: Int = 0
    @objc dynamic var movieLength: Int = 0

    override static func primaryKey() -> String? {
        return "id"
    }
}
