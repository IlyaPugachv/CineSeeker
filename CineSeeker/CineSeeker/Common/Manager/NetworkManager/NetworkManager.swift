import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    static func getCollectionsFilms(completion: @escaping (Result<MovesAll, Error>) -> Void) {
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
    
    static func fetchBestMovieOfAllTime(callback: @escaping (_ result: MovieIdsResponse?, _ error: Error?) -> ()) {
        let url = "https://api.kinopoisk.dev/v1.4/movie?page=1&limit=15&selectFields=id&notNullFields&type=movie&lists=top250"
        let header: HTTPHeaders = [APIConstans.header : APIConstans.myAPI]
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: header)
            .response { response in
                var value: MovieIdsResponse?
                var err: Error?
                switch response.result {
                case .success(let data):
                    guard let data else { callback (value, err)
                        return }
//                    print("у метода fetchBestMovieOfAllTime класса NetworkService получена data \(JSON(data))")
                    do {
                        value = try JSONDecoder().decode(MovieIdsResponse.self, from: data)
                    } catch (let decodError) {
                        print("в методе fetchBestMovieOfAllTime класса NetworkService при декодировании получена ошибка:\(decodError)")
                    }
                case .failure(let error):
                    err = error
                }
                callback(value, err)
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
}

