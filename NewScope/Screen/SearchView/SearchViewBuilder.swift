//
//  SearchViewBuilder.swift
//  NewScope
//
//  Created by Ferhat Şayık on 11.10.2025.
//

import UIKit

struct SearchViewBuilder {
    static func build(coordinator: Coordinator) -> UIViewController {
        let viewModel = SearchViewModel()
        let searchViewController = SearchViewController(coordinator: coordinator, viewModel: viewModel)
        
        
        return searchViewController
        
    }
}
