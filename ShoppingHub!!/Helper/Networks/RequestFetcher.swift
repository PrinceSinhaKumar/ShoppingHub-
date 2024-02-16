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

protocol RequestFetcherDelegate {
    func fetchRequest(request: URLRequest, handler: @escaping (Data?, URLResponse?, Error?) -> ())
}

class RequestFetcher: RequestFetcherDelegate {
        
    private let session = URLSession.shared
    func fetchRequest(request: URLRequest,
                      handler: @escaping (Data?, URLResponse?, Error?) -> ()) {
        session.dataTask(with: request) { (data, response, error) in
            handler(data,response, error)
        }.resume()
        
    }

}

//Request Maker
protocol RequestMakerDelegate {
    func createRequest(endpoint:ApiEndpoint, body: Encodable?) -> URLRequest?
}

class RequestMaker: RequestMakerDelegate {
  
    func createRequest(endpoint:ApiEndpoint,
                       body: Encodable?) -> URLRequest? {
        var request = URLRequest(url: URL(string: endpoint.path)!)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let data = body {
            let encoder = JSONEncoder()
            let endcodedData = try? encoder.encode(data)
            request.httpBody = endcodedData
        }
        return request
    }
}

//JSON data parser
protocol JSONDataParserDelegate {
    func dataParser<D: Decodable>(type: D.Type, responseData: Data?, handler: @escaping (D?, Error?) -> ())
}

class JSONDataParser: JSONDataParserDelegate {
    
    func dataParser<D>(type: D.Type, responseData: Data?, handler: @escaping (D?, Error?) -> ()) where D : Decodable {
        if let data = responseData {
            do {
                let jsonDecoder = JSONDecoder()
                let result = try jsonDecoder.decode(D.self, from: data)
                handler(result, nil)
            } catch {
                handler(nil , error)
            }
        }
    }
}

//API Manager
final class APIManager {
    
    private let session = URLSession.shared
    
    static let shared = APIManager()
    
    fileprivate let requestMaker: RequestMakerDelegate
    fileprivate let requestFetcher: RequestFetcherDelegate
    fileprivate let requestParser: JSONDataParserDelegate
    
    private init(requestMaker: RequestMakerDelegate = RequestMaker(),
         requestFetcher: RequestFetcherDelegate = RequestFetcher(),
         requestParser: JSONDataParserDelegate = JSONDataParser())
    {
        self.requestMaker = requestMaker
        self.requestFetcher = requestFetcher
        self.requestParser = requestParser
    }
    
    func getRequest<D: Decodable>( from endpoint: ApiEndpoint,
                                   body: Encodable? = nil,
                                   handler: @escaping (D?, ErrorHandler?) -> ())
    {
        guard let request = requestMaker.createRequest(endpoint: endpoint,
                                                       body: body) else {
            handler(nil, .customError("bad request"))
            return
        }
        
        requestFetcher.fetchRequest(request: request) { [weak self] data, response, error in
            
            guard error == nil else {
                handler(nil, .error(error!))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                handler(nil, .customError("Invalid response"))
                return
            }
            
            self?.requestParser.dataParser(type: D.self, responseData: data) { parsedData, error in
                guard error == nil else {
                    handler(nil, .error(error!))
                    return
                }
                handler(parsedData, nil)
            }
        }
    }
  
}
