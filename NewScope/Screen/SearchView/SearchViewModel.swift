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
    
    func getSearchNewsData()
}

protocol SearchViewModelOutputProtokol: AnyObject {
    func searchArticles()
}

final class SearchViewModel: SearchViewModelProtokol {
    var searchArticles: [Article] = []
    weak var delegate: SearchViewModelOutputProtokol?
    
    func getSearchNewsData() {
        
    }
}

