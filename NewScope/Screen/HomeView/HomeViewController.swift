//
//  HomeViewController.swift
//  NewScope
//
//  Created by Ferhat Şayık on 10.10.2025.
//

import UIKit

final class HomeViewController: UIViewController {
    
    
    // MARK: - Variable
    private var viewModel: HomeViewModelProtokol
    private var coordinator: Coordinator
    
    // MARK: - UI Components
    
    private let newsCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Init
    init(coordinator: Coordinator,
         viewModel: HomeViewModelProtokol) {
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
        setupUI()
        setCollectionViewLayout()
        viewModel.getNewsData()
        
    }
    
    private func setCollectionViewLayout() {
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
        newsCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(newsCollectionView)
        
        NSLayoutConstraint.activate([
            newsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            newsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            newsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
            
    }
        
}
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? UICollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .systemBlue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spacing: CGFloat = 10
        let totalSpacing = spacing * 3
        
        let width = (collectionView.bounds.width - totalSpacing) / 2
        let height: CGFloat = 320
        
        return CGSize(width: width, height: height)
    }
    
}

// MARK: - HomeViewModelOutputProtokol
extension HomeViewController: HomeViewModelOutputProtokol {
    func updateArticles() {
        DispatchQueue.main.async {
            self.newsCollectionView.reloadData()
        }
    }
}
