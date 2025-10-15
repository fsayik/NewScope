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
    func isBookmarked() -> Bool
}

protocol NewsDetailViewModelOutputProtokol: AnyObject {
    func updateBookmarkButton()
}

final class NewsDetailViewModel: NewsDetailViewModelProtokol {
    
    weak var delegate: NewsDetailViewModelOutputProtokol?
    var newsDetail: Article?
    
    init(newsDetail: Article) {
        self.newsDetail = newsDetail
    }
    
    func addToBookmarks() {
        if BookmarkManager.shared.isBookmarked(with: newsDetail!) {
            BookmarkManager.shared.remove(with: newsDetail!)
            delegate?.updateBookmarkButton()
        } else {
            BookmarkManager.shared.add(with: newsDetail!)
            delegate?.updateBookmarkButton()
        }
    }
    
    func isBookmarked() -> Bool {
        return BookmarkManager.shared.isBookmarked(with: newsDetail!)
    }
}
