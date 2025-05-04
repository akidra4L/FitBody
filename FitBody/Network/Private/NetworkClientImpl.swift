import Alamofire

// MARK: - Constants

fileprivate enum Constants {
    static let baseURL = "google.com"
}

// MARK: - NetworkClientImpl

final class NetworkClientImpl: NetworkClient {
    private let session = Session()
    
    func request<Parameters: Encodable & Sendable, Response: Decodable & Sendable>(
        _ baseURL: String?,
        _ relativePath: String,
        method: HTTPMethod,
        parameters: Parameters,
        headers: HTTPHeaders?
    ) async throws -> Response {
        let request = session.request(
            (baseURL ?? Constants.baseURL) + relativePath,
            method: method,
            parameters: parameters,
            headers: headers
        )
        
        return try await request.validate().response()
    }
}
