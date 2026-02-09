import Foundation

enum APIEndPoint {
    case list
    case detail(id: String)
    
    var url: URL {
        switch self {
        case .list:
            URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
        case .detail(id: let id):
            URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)")!
        }
    }
}


protocol NetworkProtocol {
    func fetch<T>(_ url: URL) async throws -> T where T : Decodable
    func fetch<T>(_ endPoint: APIEndPoint) async throws -> T where T : Decodable
}

extension NetworkProtocol {
    func fetch<T>(_ endPoint: APIEndPoint) async throws -> T where T : Decodable {
        try await fetch(endPoint.url)
    }
}

final class NetworkManager: NetworkProtocol {
    
    private let urlSession: URLSession
    
    private let decoder = JSONDecoder()
    
    private var errorService: NetworkHTTPResponseService?
    
    // Initializer allowing for dependency injection of a URLSession, defaults to the shared session.
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetch<T>(_ url: URL) async throws(NetworkHTTPResponseService) -> T where T : Decodable {
        let data: Data
        let response: URLResponse
        
        do {
            (data, response) = try await urlSession.data(from: url)
        } catch let error as URLError {
            switch error.code {
            case .badURL:
                throw NetworkHTTPResponseService.badRequest(codeError: .badURL)
            case .timedOut:
                throw NetworkHTTPResponseService.badRequest(codeError: .timedOut)
            default:
                throw NetworkHTTPResponseService.badRequest(codeError: .unknown)
            }
        } catch {
             throw NetworkHTTPResponseService.badRequest(codeError: .unknown)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkHTTPResponseService.badRequest(codeError: .invalidResponse)
        }
        
        let responseStatus = NetworkHTTPResponseService(urlResponse: httpResponse)
        
        switch responseStatus {
        case .successfulResponse:
            do {
                let result = try decoder.decode(T.self, from: data)
                return result
            } catch {
                throw NetworkHTTPResponseService.badRequest(codeError: .decodingError)
            }
        default:
            throw responseStatus
        }
    }
    
}

