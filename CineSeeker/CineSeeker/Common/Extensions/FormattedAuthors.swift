import Foundation

extension ReviewModel {
    func formattedReviews() -> String {
        return self.docs?.compactMap { $0.review }.joined(separator: "\n\n") ?? "No reviews available"
    }
    
    func formattedAuthors() -> String {
        return self.docs?.compactMap { $0.author }.joined(separator: "\n\n") ?? "No author available"
    }
}

extension MovieRandom {
    func formattedGenres() -> String {
        return self.genres?.compactMap { $0.name }.joined(separator: ", ") ?? ""
    }
}
