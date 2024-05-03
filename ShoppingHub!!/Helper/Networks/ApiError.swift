import Foundation

enum ApiError: Error {
    case parseError
    case customError(String)
}

extension ApiError {
    var description: String {
        switch self {
        case .parseError:
            return self.localizedDescription
        case .customError(let errorMessage):
            return errorMessage
        }
    }
}
