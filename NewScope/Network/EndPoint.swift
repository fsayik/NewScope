//
//  EndPoint.swift
//  NewScope
//
//  Created by Ferhat Şayık on 7.10.2025.
//

import Foundation

protocol EndpointProtocol {
    var baseUrl: String {get}
    var path : String {get}
    var method : HttpMethod {get}
    var parameters : [URLQueryItem]? {get}
    func request () -> URLRequest
}

enum HttpMethod : String {
    case get = "GET"
}

enum EndPoint {
    case topHeadlines
    case everything(q: String, language: String)
}

extension EndPoint: EndpointProtocol {
    var baseUrl: String {
        return "https://newsapi.org"
    }
    
    var path: String {
        switch self {
        case .topHeadlines:
            return "/v2/top-headlines"
        case .everything:
            return "/v2/everything"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .everything, .topHeadlines:
            return .get
        
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case .everything(let q, let language):
            return [URLQueryItem(name: "q", value: q),
                    URLQueryItem(name: "apiKey", value: Constants.apiKey),
                    URLQueryItem(name: "language", value: language)]
        case .topHeadlines:
            return [URLQueryItem(name: "apiKey", value: Constants.apiKey),
                    URLQueryItem(name: "country", value: "us")]
        }
    }
    
    func request() -> URLRequest {
        guard var comp = URLComponents(string: baseUrl) else { fatalError("URL ERROR") }
        comp.path = path
        comp.queryItems = parameters
        
        
        var request = URLRequest(url: comp.url!)
        request.httpMethod = method.rawValue
        request.timeoutInterval = 10
        
        
        return request
    }
    
}
