//
//  HomeViewBuilder.swift
//  NewScope
//
//  Created by Ferhat Şayık on 10.10.2025.
//

import UIKit

struct HomeViewBuilder {
    static func build(coordinator: Coordinator) -> UIViewController {
        let viewModel = HomeViewModel()
        let homeViewController = HomeViewController(coordinator: coordinator, viewModel: viewModel)
        
        
        return homeViewController
        
    }
}
