//
//  BookmarkViewBuilder.swift
//  NewScope
//
//  Created by Ferhat Şayık on 11.10.2025.
//

import UIKit

struct BookmarkViewBuilder {
    static func build(coordinator: Coordinator) -> UIViewController {
        let viewModel = BookmarkViewModel()
        let bookmarkViewController = BookmarkViewController(coordinator: coordinator, viewModel: viewModel)
        
        
        return bookmarkViewController
        
    }
}
