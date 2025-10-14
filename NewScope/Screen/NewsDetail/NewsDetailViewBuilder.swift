//
//  NewsDetailViewBuilder.swift
//  NewScope
//
//  Created by Ferhat Şayık on 13.10.2025.
//

import UIKit

struct NewsDetailViewBuilder {
    static func build(coordinator: Coordinator, news: Article) -> UIViewController {
        let viewModel = NewsDetailViewModel(newsDetail: news)
        let newsDetailViewController = NewsDetailViewController(coordinator: coordinator, viewModel: viewModel)
        
        
        return newsDetailViewController
        
    }
}
