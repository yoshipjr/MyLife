import Foundation

struct APIClient {
    func request<R: Request, T>(
        item: R,
        useTestData: Bool = false,
        completion: @escaping (Result<T, APIError>) -> Void
    ) where R.Response == T {
        #if DEBUG
        if useTestData {
            let testDataFetchRequest = TestDataFetchRequest(testDataJsonPath: item.testDataPath)
            completion(testDataFetchRequest.fetchLocalTestData(responseType: T.self))
            return
        }
        #endif
        
        if let cache = item.localDataInterceptor(item.parameters), item.wantCache {
            completion(.success(cache))
        }

        guard let urlRequest = createURLRequest(item) else {
            completion(.failure(.invalidRequest))
            return
        }

        debugPrint(urlRequest)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, _ in

            guard let data = data else {
                completion(.failure(.responseError))
                return
            }
            decode(data: data, completion: completion)
        }
        task.resume()

    }

    private func decode<T: Decodable>(
        data: Data,
        completion: @escaping (Result<T, APIError>) -> Void
    ) {
        do {
            let value = try JSONDecoder().decode(T.self, from: data)
            completion(.success(value))
        } catch {
            if let error = error as? DecodingError {
                debugPrint("[DecodeError Class]: \(T.self)")
                debugPrint("[DecodeError Data]: \(data.prettyPrintedJsonString)")
                debugPrint("[DecodeError Keys]: \(error.keys)")
                debugPrint("[DecodeError DebugDescription]: \(error.debugDescription)")
                debugPrint("[DecodeError LocalizedDescription]: \(error.localizedDescription)")
            }
            completion(.failure(.decodeError(error.localizedDescription)))
        }
    }

    private func createURLRequest<R: Request>(_ requestItem: R) -> URLRequest? {
        guard let fullPath = URL(string: requestItem.baseURL + requestItem.path) else { return nil }

        var urlComponents = URLComponents()

        urlComponents.scheme = fullPath.scheme
        urlComponents.host = fullPath.host
        urlComponents.path = fullPath.path
        urlComponents.port = fullPath.port
        urlComponents.queryItems = requestItem.queryItems

        guard let url = urlComponents.url else { return nil }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestItem.method.rawValue
        urlRequest.httpBody = requestItem.body
        requestItem.headers.forEach { urlRequest.addValue($1, forHTTPHeaderField: $0) }

        return urlRequest
    }
}
