//
//  NetworkError.swift
//  NewScope
//
//  Created by Ferhat Şayık on 7.10.2025.
//

import Foundation

// MARK: - NetworkError Enum
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case httpError(Int)
    case decodingError(String)
    case networkError(String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided is invalid."
        case .invalidResponse:
            return "The server response was invalid."
        case .httpError(let statusCode):
            return "HTTP Error: Received status code \(statusCode)."
        case .decodingError(let message):
            return "Decoding Error: \(message)"
        case .networkError(let message):
            return "Network Error: \(message)"
        }
    }
}
