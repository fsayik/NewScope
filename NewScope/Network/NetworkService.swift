//
//  NetworkService.swift
//  NewScope
//
//  Created by Ferhat Şayık on 7.10.2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func getNews(completion: @escaping (Result<NewsData, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol, NetworkManager {
    
    
    static let shared = NetworkService()
    
    private init(){}
    
    
    func getNews(completion: @escaping (Result<NewsData, Error>) -> Void) {
        let endpoint = EndPoint.topHeadlines
        execute(endpoint, completion: completion)
    }
}
