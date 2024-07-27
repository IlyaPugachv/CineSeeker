import UIKit

extension Detail {
    class Presenter {
        
        // MARK: - Properties -
        
        weak var view: DetailView?
        
        var image: UIImage?
        var title: String
        var rating: Double
        var year: Int
        var movieLength: Int
        var genres: String
        var aboutMovie: String
        var author: String
        var review: String
        
        // MARK: - Initializers - 
        
        init(image: UIImage?, title: String, rating: Double, year: Int, movieLength: Int, genres: String, aboutMovie: String, autor: String, review: String) {
            self.image = image
            self.title = title
            self.rating = rating
            self.year = year
            self.movieLength = movieLength
            self.genres = genres
            self.aboutMovie = aboutMovie
            self.author = autor
            self.review = review
        }
        
        deinit {
            print(#function, self)
        }
        
        // MARK: - Methods -
        
    }
}

