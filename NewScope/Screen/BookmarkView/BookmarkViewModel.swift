//
//  BookmarkViewModel.swift
//  NewScope
//
//  Created by Ferhat Şayık on 11.10.2025.
//

import Foundation

protocol BookmarkViewModelProtokol {
    var bookmarkArticles: [Article] { get set }
    var delegate: BookmarkViewModelOutputProtokol? { get set }
    
    func getBookmarkArticles()
    func removeBookmark(with article: Article)
    
}

protocol BookmarkViewModelOutputProtokol: AnyObject {
    func updateCollectionView()
}

final class BookmarkViewModel: BookmarkViewModelProtokol {
    var bookmarkArticles: [Article] = []
    weak var delegate: BookmarkViewModelOutputProtokol?
    
    func getBookmarkArticles() {
        bookmarkArticles = BookmarkManager.shared.getBookmarks()
        delegate?.updateCollectionView()
    }
    
    func removeBookmark(with article: Article) {
        BookmarkManager.shared.remove(with: article)
        getBookmarkArticles()
        delegate?.updateCollectionView()
    }
}
