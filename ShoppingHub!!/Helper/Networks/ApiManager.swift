import Foundation

enum ErrorHandler {    
    case error(Error)
    case customError(String)
}
extension ErrorHandler {
    var errorMessage: String {
        switch self {
        case .error(let error):
            return error.localizedDescription
        case .customError(let customError):
            return customError
        }
        
    }
}

protocol ApiManagerDelegate {
    func getData<D: Decodable>(from endpoint: ApiEndpoint, handler: @escaping (D?, ErrorHandler?) -> ())
    func sendData<D: Decodable, E: Encodable>(from endpoint: ApiEndpoint, with body: E, handler: @escaping (D?, ErrorHandler?) -> ())
    func createRequest(from endpoint: ApiEndpoint) -> URLRequest?
}

final class ApiManager: ApiManagerDelegate {
    
    typealias NetworkResponse = (data: Data, response: URLResponse)
    
    static let shared = ApiManager()
    
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
      
    func getData<D: Decodable>(from endpoint: ApiEndpoint, handler: @escaping (D?, ErrorHandler?) -> ()) {
        guard let request = createRequest(from: endpoint) else { return }
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                handler(nil, .error(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                handler(nil, .customError("Invalid response"))
                return
            }
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let result = try jsonDecoder.decode(D.self, from: data)
                    handler(result, nil)
                } catch {
                    handler(nil , .error(error))
                }
            }
        }
        task.resume()
    }
    
    func sendData<D: Decodable, E: Encodable>(from endpoint: ApiEndpoint, with body: E, handler: @escaping (D?, ErrorHandler?) -> ()) {
        guard var request = createRequest(from: endpoint) else { return }
        let data = try! encoder.encode(body)
        request.httpBody = data
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                handler(nil, .error(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                handler(nil, .customError("Invalid response"))
                return
            }
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let result = try jsonDecoder.decode(D.self, from: data)
                    handler(result, nil)
                } catch {
                    handler(nil , .error(error))
                }
            }
        }
        task.resume()
    }
}

extension ApiManager {
    
    func createRequest(from endpoint: ApiEndpoint) -> URLRequest? {
        var request = URLRequest(url: URL(string: endpoint.path)!)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
