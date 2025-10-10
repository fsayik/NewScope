//
//  BookmarkViewController.swift
//  NewScope
//
//  Created by Ferhat Şayık on 11.10.2025.
//

import UIKit

final class BookmarkViewController: UIViewController {

    // MARK: - Variable
    private var viewModel: BookmarkViewModelProtokol
    private var coordinator: Coordinator
    
    // MARK: - UI Components
    
    // MARK: - Init
    init(coordinator: Coordinator,
         viewModel: BookmarkViewModelProtokol) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        view.backgroundColor = .systemCyan
    }
    
    
    // MARK: - UI Setup
    
    
}

// MARK: - Extension


extension BookmarkViewController: BookmarkViewModelOutputProtokol {
    func searchArticles() {
        print("Update")
    }
    
}
