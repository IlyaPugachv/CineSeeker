import Foundation

struct ReviewModel: Codable {
    let docs: [Doc]?
    let total: Int?
    let limit: Int?
    let page: Int?
    let pages: Int?
}

struct Doc: Codable {
    let id: Int?
    let movieId: Int?
    let title: String?
    let type: String?
    let review: String?
    let date: String?
    let author: String?
    let userRating: Int?
    let authorId: Int?
    let updatedAt: String? 
    let createdAt: String?
}
