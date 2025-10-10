//
//  TabBarViewController.swift
//  NewScope
//
//  Created by Ferhat Şayık on 11.10.2025.
//

import UIKit

final class TabBarViewController: UITabBarController {

    // MARK: - Variable
    private var coordinator: Coordinator
    
    // MARK: - UI Components
    
    // MARK: - Init
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    // MARK: - UI Setup
    private func setupTabBar() {
        view.backgroundColor = .systemBackground
        
        let vc1 = HomeViewBuilder.build(coordinator: coordinator)
        let vc2 = SearchViewBuilder.build(coordinator: coordinator)
        let vc3 = BookmarkViewBuilder.build(coordinator: coordinator)
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        nav2.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        nav3.tabBarItem = UITabBarItem(title: "Bookmark", image: UIImage(systemName: "bookmark.circle"), selectedImage: UIImage(systemName: "bookmark.circle.fill"))
        
        tabBar.tintColor = .systemRed
        tabBar.unselectedItemTintColor = .systemGray
        setViewControllers([nav1, nav2, nav3], animated: true)
        
    }
    
}

// MARK: - Extension
