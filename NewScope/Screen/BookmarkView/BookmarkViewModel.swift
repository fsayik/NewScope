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
    
}

protocol BookmarkViewModelOutputProtokol: AnyObject {
    func searchArticles()
}

final class BookmarkViewModel: BookmarkViewModelProtokol {
    var bookmarkArticles: [Article] = []
    weak var delegate: BookmarkViewModelOutputProtokol?
}
