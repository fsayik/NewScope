//
//  BookmarkManager.swift
//  NewScope
//
//  Created by Ferhat Şayık on 14.10.2025.
//

import Foundation

final class BookmarkManager {
    static let shared = BookmarkManager()
    private let key = "bookmarkedArticles"

    private init() {}
    
    func getBookmarks() -> [Article] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        return (try? JSONDecoder().decode([Article].self, from: data)) ?? []
    }

    func add(with article: Article) {
        var current = getBookmarks()
        guard !current.contains(where: { $0.url == article.url }) else { return }
                current.append(article)
                save(current)
    }

    func remove(with article: Article) {
        var current = getBookmarks()
                current.removeAll { $0.url == article.url }
                save(current)
    }

    func isBookmarked(with article: Article) -> Bool {
        return getBookmarks().contains(where: { $0.url == article.url })
    }

    private func save(_ articles: [Article]) {
        if let data = try? JSONEncoder().encode(articles) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
