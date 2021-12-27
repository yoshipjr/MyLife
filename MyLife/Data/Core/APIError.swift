import Foundation

public enum APIError: LocalizedError, Equatable {
    case unknown
    case missingTestJsonDataPath
    case invalidRequest
    case offline
    case decodeError(String)
    case responseError

    public var errorDescription: String? {
        switch self {
            case .unknown:
                return "unknown error occured"

            case .missingTestJsonDataPath:
                return "missing test json data path"

            case .invalidRequest:
                return "invalid request"

            case .offline:
                return "offline error occured"

            case let .decodeError(error):
                return "decode error occured, \(error)"

            case .responseError:
                return "response error occured"
        }
    }
}

extension DecodingError {
    var context: DecodingError.Context? {
        switch self {
            case .typeMismatch(_, let context):
                return context

            case .valueNotFound(_, let context):
                return context

            case .keyNotFound(_, let context):
                return context

            case .dataCorrupted(let context):
                return context

            default:
                return nil
        }
    }

    var debugDescription: String {
        return context?.debugDescription ?? ""
    }

    var keys: String {
        return context?.codingPath.map { $0.stringValue }.description ?? ""
    }
}
