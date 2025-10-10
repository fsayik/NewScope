//
//  HomeViewModel.swift
//  NewScope
//
//  Created by Ferhat Şayık on 10.10.2025.
//

import Foundation

protocol HomeViewModelProtokol {
    var articles: [Article] { get set }
    var delegate: HomeViewModelOutputProtokol? { get set }
    
    func getNewsData()
}

protocol HomeViewModelOutputProtokol: AnyObject {
    func updateArticles()
}


final class HomeViewModel: HomeViewModelProtokol {
    
    var articles: [Article] = []
    weak var delegate: HomeViewModelOutputProtokol?
        
    func getNewsData() {
        NetworkService.shared.getNews { [weak self] result in
            switch result {
            case .success(let newsData):
                self?.articles = newsData.articles!
                self?.delegate?.updateArticles()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
