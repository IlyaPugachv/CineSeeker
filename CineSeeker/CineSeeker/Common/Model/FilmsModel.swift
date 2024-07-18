import UIKit

// Структура для внешнего идентификатора фильма
struct ExternalId: Codable {
    let kpHD: String?
    let imdb: String?
    let tmdb: Int?
}

// Структура для представления персоны (актера)
struct Person: Codable {
    let id: Int
    let photo: String?
    let name: String?
    let enName: String?
    let description: String?
    let profession: String?
    let enProfession: String?
}

// Структура для представления жанра
struct Genre: Codable {
    let name: String?
    let slug: String?
}

// Структура для представления рейтинга
struct Rating: Codable {
    let kp: Double?
    let imdb: Double?
    let tmdb: Double?
    let filmCritics: Double?
    let russianFilmCritics: Double?
    let await: Double?
}

// Структура для представления изображения
struct Image: Codable {
    let url: String?
    let previewUrl: String?
}

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

struct MovieByWord: Codable {
    let pages: Int?
    let total: Int?
    let page: Int?
    let docs: [MovieDetail]
    let limit: Int?
}

// Главная структура для представления фильма
struct MovieDetail: Codable {
    let id: Int
    let externalId: ExternalId?
    let name: String?
    let alternativeName: String?
    let enName: String?
    let type: String?
    let typeNumber: Int?
    let year: Int?
    let description: String?
    let shortDescription: String?
    let slogan: String?
    let status: String?
    let rating: Rating?
    let movieLength: Int?
    let ratingMpaa: String?
    let ageRating: Int?
    let logo: Image?
    let poster: Image?
    let backdrop: Image?
    let genres: [Genre]?
    let persons: [Person]?
    let reviewInfo: ReviewInfo?
    let watchability: Watchability?
    let releaseYears: [ReleaseYear]?
    let top10: Int?
    let top250: Int?
    let ticketsOnSale: Bool?
    let totalSeriesLength: Int?
    let seriesLength: Int?
    let isSeries: Bool?
    let lists: [String]?
    let networks: [Network]?
    let updatedAt: String?
    let createdAt: String?
    let imagesInfo: ImagesInfo?
}

// Вспомогательная структура для представления имени
struct Name: Codable {
    let name: String?
    let language: String?
    let type: String?
}

// Вспомогательная структура для представления голосов
struct Votes: Codable {
    let kp: String?
    let imdb: Int?
    let tmdb: Int?
    let filmCritics: Int?
    let russianFilmCritics: Int?
    let await: Int?
}


// Вспомогательная структура для представления информации о рецензиях
struct ReviewInfo: Codable {
    let count: Int?
    let positiveCount: Int?
    let percentage: String?
}

// Структура для представления информации о просмотрах
struct Watchability: Codable {
    let items: [WatchabilityItem]
}

// Вспомогательная структура для представления элемента просмотра
struct WatchabilityItem: Codable {
    let name: String?
    let logo: Image?
    let url: String?
}

// Структура для представления информации о годе выпуска
struct ReleaseYear: Codable {
    let start: Int
    let end: Int
}

// Структура для представления сети
struct Network: Codable {
    let items: [NetworkItem]
}

// Вспомогательная структура для представления элемента сети
struct NetworkItem: Codable {
    let name: String?
    let logo: Image?
}

// Структура для представления информации о изображениях
struct ImagesInfo: Codable {
    let postersCount: Int?
    let backdropsCount: Int?
    let framesCount: Int?
}

// Структура для представления элемента списка
struct ListItem: Codable {
    let listName: String?
}

// Структура для представления информации о плейлисте
struct PlaylistInfo: Codable {
    let playlists: [ListItem]?
}


