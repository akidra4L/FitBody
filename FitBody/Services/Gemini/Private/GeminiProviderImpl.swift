import Foundation

final class GeminiProviderImpl: GeminiProvider {
    func get(with request: GeminiRequest) async throws -> String? {
        let baseURL = "https://generativelanguage.googleapis.com"
        let modelName = "gemini-1.5-flash"
        let urlSession = URLSession.shared
        
        guard let apiKey = getApiKey() else {
            return nil
        }
        
        let urlString = "\(baseURL)/v1beta/models/\(modelName):generateContent?key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            return nil
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let encoder = JSONEncoder()
        do {
            urlRequest.httpBody = try encoder.encode(request)
        } catch {
            return nil
        }

        let data: Data
        let response: URLResponse
        
        do {
            (data, response) = try await urlSession.data(for: urlRequest)
        } catch {
            return nil
        }
        
        guard response is HTTPURLResponse else {
            return nil
        }

        let decoder = JSONDecoder()
        do {
            let geminiResponse = try decoder.decode(GetGeminiResponse.self, from: data)
            
            return geminiResponse.generatedText
        } catch {
            return nil
        }
    }
    
    private func getApiKey() -> String? {
        guard
            let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path),
            let key = dict["GEMINI_API_KEY"] as? String
        else {
            return nil
        }
        
        return key
    }
}
