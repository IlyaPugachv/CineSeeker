import UIKit

struct MovesAll: Codable {
    let docs: [MovieRandom]?
}

struct MovieRandom: Codable {
    let id: Int?
    let name: String?
    let alternativeName: String?
    let enName: String?
    let type: String?
    let typeNumber: Int?
    let year: Int?
    let description: String?
    let shortDescription: String?
    let status: String?
    let rating: Rating?
    let votes: Votes?
    let movieLength: Int?
    let totalSeriesLength: Int?
    let seriesLength: Int?
    let ratingMpaa: String?
    let ageRating: Int?
    let poster: Poster?
    let genres: [Genre]?
    let countries: [Country]?
    let top10: Int?
    let top250: Int?
    let isSeries: Bool?
    let ticketsOnSale: Bool?
}

struct Rating: Codable {
    let kp: Double?
    let imdb: Double?
    let filmCritics: Double?
    let russianFilmCritics: Double?
    let await: Double?
}

struct Votes: Codable {
    let kp: Int?
    let imdb: Int?
    let filmCritics: Int?
    let russianFilmCritics: Int?
    let await: Int?
}

struct Poster: Codable {
    let url: String?
    let previewUrl: String?
}

struct Genre: Codable {
    let name: String?
}

struct Country: Codable {
    let name: String?
}

