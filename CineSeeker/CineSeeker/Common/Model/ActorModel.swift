import Foundation

struct Actor: Codable {
    let docs: [Docs]?
    let total: Int?
    let limit: Int?
    let page: Int?
    let pages: Int?
}

struct Docs: Codable {
    let id: Int?
    let name: String?
    let enName: String?
    let photo: String?
    let sex: String?
    let growth: Int?
    let birthday: String?
    let death: String?
    let age: Int?
    let birthPlace: [BirthPlace]?
    let deathPlace: [DeathPlace]?
    let spouses: [Spouses]
    let countAwards: Int?
    let profession: [Profession]
    let facts: [Facts]?
    let movies: [Movies]?
    let updatedAt: String?
    let createdAt: String?
}

struct BirthPlace: Codable {
    let value: String?
}

struct DeathPlace: Codable {
    let value: String?
}

struct Spouses: Codable {
    let id: Int?
    let name: String?
    let divorced: Bool
    let divorcedReason: String?
    let sex: String?
    let children: Int?
    let relation: String?
}

struct Profession: Codable {
    let value: String?
}

struct Facts: Codable {
    let value: String?
}

struct Movies: Codable {
    let id: Int?
    let name: String?
    let alternativeName: String?
    let rating: Int?
    let general: Bool
    let description: String?
    let enProfession: String?
}
