//
//  OpenApiWrapper.swift
//  IELTS Speaking Buddy
//
//  Created by Sourav on 3/9/24.
//

import Foundation

enum OpenApiWrapperError: Error {
    case apiKeyNotFound
}

class OpenApiWrapper {

    let openAIUrl = URL(string: "https://api.openai.com/v1/chat/completions")!

    func createChatCompletion(prompt: String) async throws -> String? {

        let apiKey = try getOpenApiKey()
        
        let headers = [
            "Authorization": "Bearer \(apiKey)",
            "Content-Type": "application/json"
        ]


        // Define the parameters for the chat completion request
        let parameters: [String: Any] = [
            "model": "gpt-4o-mini", // Specify the model to use
            "messages": [
                ["role": "system", "content": "You are a helpful assistant."],
                ["role": "user", "content": prompt]
            ],
        ]

        // Convert the parameters to JSON data
        let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])

        // Create the request
        var request = URLRequest(url: openAIUrl)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = jsonData

        // Perform the API request asynchronously
        let (data, _) = try await URLSession.shared.data(for: request)

        if let responseString = String(data: data, encoding: .utf8) {
            print("Response as String: \(responseString)")
        } else {
            print("Failed to convert data to String.")
        }


        // Parse the response JSON to extract the completion
        if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
           let choices = jsonResponse["choices"] as? [[String: Any]],
           let message = choices.first?["message"] as? [String: Any],
           let content = message["content"] as? String {
            print("API: response is \(jsonResponse)")
            return content
        } else {
            return nil
        }
    }

    func getOpenApiKey() throws -> String {
        if let apiKey = Bundle.main.infoDictionary?["OPEN_AI_KEY"] as? String {
            print("OPEN_AI_KEY:" + apiKey)
            return apiKey
        } else {
            print("OPEN_AI_KEY not found")
            throw OpenApiWrapperError.apiKeyNotFound
        }
    }
}
