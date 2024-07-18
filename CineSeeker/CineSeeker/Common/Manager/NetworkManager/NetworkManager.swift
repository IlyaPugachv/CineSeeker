import UIKit
import Alamofire

final class NetworkManager {
    
    static func fetchBestMovieOfAllTime(callback: @escaping (_ result: MovieIdsResponse?, _ error: Error?) -> ()) {
        let url = "https://api.kinopoisk.dev/v1.4/movie?page=1&limit=15&selectFields=id&notNullFields&type=movie&lists=top250"
        let header: HTTPHeaders = ["X-API-KEY": APIConstans.myAPI]
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: header)
            .response { response in
                var value: MovieIdsResponse?
                var err: Error?
                switch response.result {
                case .success(let data):
                    guard let data else { callback (value, err)
                        return }
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
}
