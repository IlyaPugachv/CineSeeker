import Foundation

struct MovieId: Codable {
    let id: Int
}

struct MovieIdsResponse: Codable {
    let docs: [MovieId]
    let total: Int?
    let limit: Int?
    let page: Int?
    let pages: Int?
}
