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
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        let numberOfColumns: CGFloat = 2
        let totalHorizontalPadding = layout.sectionInset.left + layout.sectionInset.right + (layout.minimumInteritemSpacing * (numberOfColumns - 1))
        let cellWidth = (UIScreen.main.bounds.width - totalHorizontalPadding) / numberOfColumns
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.3)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
        newsCollectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: NewsCollectionViewCell.identifier)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(newsCollectionView)
        
        NSLayoutConstraint.activate([
            newsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            newsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
            
    }
        
}
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.identifier, for: indexPath) as? NewsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: viewModel.articles[indexPath.item])
        return cell
    }
    
    /*func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30) / 2
        return CGSize(width: width,
                      height: width*1.5)
    }*/
        
}

// MARK: - HomeViewModelOutputProtokol
extension HomeViewController: HomeViewModelOutputProtokol {
    func updateArticles() {
        DispatchQueue.main.async {
            self.newsCollectionView.reloadData()
        }
    }
}
