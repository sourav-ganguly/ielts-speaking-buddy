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
    func getOpenApiKey() throws -> String {
        if let apiKey = Bundle.main.infoDictionary?["OPEN_AI_KEY"] as? String {
            print("Sourav" + apiKey)
            return apiKey
        } else {
            print("Sourav OPEN_AI_KEY not found")
            throw OpenApiWrapperError.apiKeyNotFound
        }
    }
}
