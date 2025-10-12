//
//  SearchViewModel.swift
//  NewScope
//
//  Created by Ferhat Şayık on 11.10.2025.
//

import Foundation

protocol SearchViewModelProtokol {
    var searchArticles: [Article] { get set }
    var delegate: SearchViewModelOutputProtokol? { get set }
    
    func getSearchNewsData(q: String)
    func clearSearchArticles()
}

protocol SearchViewModelOutputProtokol: AnyObject {
    func updateCollectionView()
}

final class SearchViewModel: SearchViewModelProtokol {
    var searchArticles: [Article] = []
    weak var delegate: SearchViewModelOutputProtokol?
    
    func getSearchNewsData(q: String) {
        NetworkService.shared.getSearch(q: q) { [weak self] Result in
            switch Result {
            case .success(let articles):
                self?.searchArticles = articles.articles!
                self?.delegate?.updateCollectionView()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func clearSearchArticles() {
        searchArticles = []
        delegate?.updateCollectionView()
    }
}

