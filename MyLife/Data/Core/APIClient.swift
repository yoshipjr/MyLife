import Foundation

struct APIClient {
    func request<R: Request, T>(
        item: R,
        useTestData: Bool = false,
        completion: @escaping (Result<T, APIError>) -> Void
    ) where R.Response == T {
        #if DEBUG
        if useTestData {
            return
        }
        #endif
    }
}
