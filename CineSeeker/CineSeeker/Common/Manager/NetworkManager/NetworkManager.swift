import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    static func fetchRandomMovies(completion: @escaping (Result<MovesAll, Error>) -> Void) {
        let url = "\(APIConstans.request)v1.4/movie?page=1&limit=7"
        let headers: HTTPHeaders = [APIConstans.header : APIConstans.myAPI]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(MovesAll.self, from: data)
                        completion(.success(result))
                    } catch {
                        print("Ошибка декодирования: \(error)")
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                print("Ошибка при выполнении запроса: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    static func fetchNowPlayingMovies(completion: @escaping (Result<MovesAll, Error>) -> Void) {
        let url = "\(APIConstans.request)v1.4/movie?rating.imdb=1-4"
        let headers: HTTPHeaders = [APIConstans.header : APIConstans.myAPI]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(MovesAll.self, from: data)
                        completion(.success(result))
                    } catch {
                        print("Ошибка декодирования: \(error)")
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                print("Ошибка при выполнении запроса: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    static func fetchUpcomingMovies(completion: @escaping (Result<MovesAll, Error>) -> Void) {
        let url = "\(APIConstans.request)v1.4/movie?year=2023&genres.name=криминал"
        let headers: HTTPHeaders = [APIConstans.header : APIConstans.myAPI]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(MovesAll.self, from: data)
                        completion(.success(result))
                    } catch {
                        print("Ошибка декодирования: \(error)")
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                print("Ошибка при выполнении запроса: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    static func fetchTopRatedMovies(completion: @escaping (Result<MovesAll, Error>) -> Void) {
        let url = "\(APIConstans.request)v1.4/movie?rating.imdb=5-7"
        let headers: HTTPHeaders = [APIConstans.header : APIConstans.myAPI]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(MovesAll.self, from: data)
                        completion(.success(result))
                    } catch {
                        print("Ошибка декодирования: \(error)")
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                print("Ошибка при выполнении запроса: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    static func fetchPopularMovies(completion: @escaping (Result<MovesAll, Error>) -> Void) {
        let url = "\(APIConstans.request)v1.4/movie?rating.imdb=8-10"
        let headers: HTTPHeaders = [APIConstans.header : APIConstans.myAPI]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(MovesAll.self, from: data)
                        completion(.success(result))
                    } catch {
                        print("Ошибка декодирования: \(error)")
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                print("Ошибка при выполнении запроса: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    static func getReviewsForMovie(movieId: Int, completion: @escaping (Result<ReviewModel, Error>) -> Void) {
        let url = "https://api.kinopoisk.dev/v1.4/review?page=1&limit=10"
        let headers: HTTPHeaders = [APIConstans.header : APIConstans.myAPI]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(ReviewModel.self, from: data)
                        completion(.success(result))
                    } catch {
                        print("Ошибка декодирования: \(error)")
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                print("Ошибка при выполнении запроса: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    static func searchMoviesByName(movieName: String, completion: @escaping (Result<MovesAll, Error>) -> Void) {
        let url = "https://api.kinopoisk.dev/v1.4/movie/search"
        let headers: HTTPHeaders = [APIConstans.header : APIConstans.myAPI]
        
        let parameters: Parameters = [
            "query": movieName,
            "page": 1,
            "limit": 10
        ]
        
        AF.request(url, method: .get, parameters: parameters, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(MovesAll.self, from: data)
                        completion(.success(result))
                    } catch {
                        print("Ошибка декодирования: \(error)")
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                print("Ошибка при выполнении запроса: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}

