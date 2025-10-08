//
//  NetworkManager.swift
//  NewScope
//
//  Created by Ferhat Şayık on 7.10.2025.
//

import Foundation

protocol NetworkManager {
    func execute<T: Codable>(
                _ endpoint: EndPoint,
                completion: @escaping (Result<T, Error>) -> Void
            )
}

extension NetworkManager {
    
    func execute<T: Codable>(
        _ endpoint: EndPoint,
        completion: @escaping (Result<T, Error>) -> Void
    ){
        
        let dataTask = URLSession.shared.dataTask(with: endpoint.request()) { data, response, error in
            print(endpoint.request())
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completion(.failure(NSError(domain: "Invalid Response", code: 0)))
                return
            }
            
            guard let data = data else{
                completion(.failure(NSError(domain: "No Data", code: 0)))
                return
            }
            
            do{
                let decodeData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodeData))
            }catch {
                completion(.failure(error))
            }
        }
        dataTask.resume()
        
    }
    
}
