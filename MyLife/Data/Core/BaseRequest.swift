import Foundation
import UIKit

public struct EmptyParamaters: Encodable, Equatable {
    public init() {}
}

public struct EmptyResponse: Codable, Equatable {
    public init() {}
}

public struct EmptyPathComponent {
    public init() {}
}

enum APIRequestHeader: String, CaseIterable {
    case accept = "Accept"
    case authorization = "Authorization"

    var value: String {
        switch self {
            case .accept:
                return ""
            case .authorization:
                return ""
        }
    }
}

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

struct HTTPStatusCode {
    static let noContent: Int = 204
    static let successRange: ClosedRange<Int> = 200 ... 299
    static let unauthorized: Int = 401
    static let notFound: Int = 404
    static let unprocessableEntity: Int = 422
    static let tooManyAccess: Int = 429
    static let serverError: Int = 500
}

public protocol Request {
    associatedtype Response: Decodable
    associatedtype Paramaters: Encodable
    associatedtype PathComponent

    var headers: [String: String] { get }
    var method: HTTPMethod { get }
    var paramaters: Paramaters { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
    var baseURL: String { get }
    var path: String { get }
    var wantCache: Bool { get }
    var setCookie: Bool { get }
    var localDataIntercptor: (Paramaters) -> Response? { get }
    var successHandler: (Response) -> Void { get }
    var failureHandler: (Error) -> Void { get }

    init(
        paramater: Paramaters,
        pathComponent: PathComponent
    )
}

public extension Request {
    var baseURL: String {
        #if DEBUG
        "https://dev" //TODO: 環境によって修正
        #else
        "https://prod"
        #endif
    }

    var queryItems: [URLQueryItem]? {
        let query: [URLQueryItem]
        if let params = paramaters as? [Encodable] {
            query = params
                .flatMap { param in param.dictionary.map { key, value in
                    URLQueryItem(name: key, value: value?.description ?? "")
                }
            }
        } else {
            query = paramaters.dictionary.map { key, value in
                URLQueryItem(name: key, value: value?.description ?? "")
            }
        }

        return query.filter {
            guard let value = $0.value, !value.isEmpty else { return false }
            return true
        }.sorted { first, second -> Bool in
            first.name > second.name
        }
    }

    var body: Data? {
        try? JSONEncoder().encode(paramaters)
    }

    var headers: [String: String] {
        var ret: [String: String] = [:]

        APIRequestHeader.allCases.forEach { header in
            ret[header.rawValue] = header.value
        }

        return ret
    }

    var wantCache: Bool { false }

    var localDataIntercptor: (Paramaters) -> Response? { { _ in nil } }
    var successHandler: (Response) -> Void { { _ in } }
    var failureHandler: (Error) -> Void { { _ in } }
    var boundary: String {
        "----WebKitFormBoundary\(UUID().uuidString)"
    }

    var setCookie: Bool {
        false
    }
}


private extension Encodable {
    var dictionary: [String: CustomStringConvertible?] {
        (
            try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))
        ) as? [String: CustomStringConvertible?] ?? [:]
    }
}
