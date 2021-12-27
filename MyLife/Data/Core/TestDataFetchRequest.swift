import Foundation

public struct TestDataFetchRequest {
    private let testDataJsonPath: URL?

    public init(testDataJsonPath: URL?) {
        self.testDataJsonPath = testDataJsonPath
    }

    public func fetchLocalTestData<T: Decodable>(responseType: T.Type) -> Result<T, APIError> {
        do {
            if let result = EmptyResponse() as? T {
                return Result.success(result)
            }

            guard let url = testDataJsonPath else {
                return Result.failure(.missingTestJsonDataPath)
            }
            let data = try Data(contentsOf: url)

            let result = try JSONDecoder().decode(T.self, from: data)
            return Result.success(result)
        } catch {
            if let error = error as? DecodingError {
                debugPrint("[DecodeError Class]: \(T.self)")
                debugPrint("[DecodeError Keys]: \(error.keys)")
                debugPrint("[DecodeError DebugDescription]: \(error.debugDescription)")
                debugPrint("[DecodeError LocalizedDescription]: \(error.localizedDescription)")
            }

            return Result.failure(.decodeError(error.localizedDescription))
        }
    }
}

extension Data {
    var prettyPrintedJsonString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintString = String(data: data, encoding: .utf8)
        else {
            return nil
        }
        return prettyPrintString
    }
}
