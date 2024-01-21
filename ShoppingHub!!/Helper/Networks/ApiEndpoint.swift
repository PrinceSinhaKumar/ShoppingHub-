import Foundation

enum ApiEndpoint {
    
    enum Method: String {
        case GET
        case POST
        case PUT
        case DELETE
    }
    
    /// Define all your endpoints here
    case getLoginContent
}

extension ApiEndpoint {

    /// The path for every endpoint
    var path: String {
        switch self {
        case .getLoginContent:
            return "auth"
        }
        
    }
    
    /// The method for the endpoint
    var method: ApiEndpoint.Method {
        switch self {
        case .getLoginContent:
            return .POST
        }
    }
    
    /// The URL parameters for the endpoint (in case it has any)
    var parameters: [URLQueryItem]? {
        switch self {
        case .getLoginContent:
            var queryItems = [URLQueryItem]()
            queryItems.append(URLQueryItem(name: "continent", value: path))
            return queryItems
        }
    }
}
