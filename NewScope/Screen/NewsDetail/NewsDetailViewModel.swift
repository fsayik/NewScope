//
//  NewsDetailViewModel.swift
//  NewScope
//
//  Created by Ferhat Şayık on 13.10.2025.
//

import Foundation

protocol NewsDetailViewModelProtokol {
    var delegate: NewsDetailViewModelOutputProtokol? { get }
    
    var newsDetail: Article? { get }
    
    func addToBookmarks()
}

protocol NewsDetailViewModelOutputProtokol: AnyObject {
    
}

final class NewsDetailViewModel: NewsDetailViewModelProtokol {
    
    weak var delegate: NewsDetailViewModelOutputProtokol?
    var newsDetail: Article?
    
    init(newsDetail: Article) {
        self.newsDetail = newsDetail
    }
    
    func addToBookmarks() {
        print("Added Bokmarks")
    }
}
