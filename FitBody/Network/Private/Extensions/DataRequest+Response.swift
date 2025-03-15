import Alamofire
import Foundation

extension DataRequest {
    func response<Response: Decodable & Sendable>() async throws -> Response {
        let task = serializingDecodable(
            Response.self,
            decoder: JSONDecoder.default
        )

        let dataResponse = await task.response
        switch dataResponse.result {
        case let .success(value):
            return value
        case let .failure(error):
            throw error
        }
    }
}
