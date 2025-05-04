import Alamofire

// MARK: - NetworkClient

protocol NetworkClient: AnyObject, Sendable {
    func request<Parameters: Encodable & Sendable, Response: Decodable & Sendable>(
        _ baseURL: String?,
        _ relativePath: String,
        method: HTTPMethod,
        parameters: Parameters,
        headers: HTTPHeaders?
    ) async throws -> Response
}

// MARK: - Convenience Methods

extension NetworkClient {
    func get<Response: Decodable & Sendable>(
        _ relativePath: String,
        parameters: Encodable & Sendable = Empty.emptyValue(),
        headers: HTTPHeaders? = nil
    ) async throws -> Response {
        try await request(
            nil,
            relativePath,
            method: .get,
            parameters: parameters,
            headers: headers
        )
    }
    
    func post<Response: Decodable & Sendable>(
        _ relativePath: String,
        parameters: Encodable & Sendable = Empty.emptyValue(),
        headers: HTTPHeaders? = nil
    ) async throws -> Response {
        try await request(
            nil,
            relativePath,
            method: .post,
            parameters: parameters,
            headers: headers
        )
    }
}
