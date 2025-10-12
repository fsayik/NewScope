//
//  SearchViewController.swift
//  NewScope
//
//  Created by Ferhat Şayık on 11.10.2025.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Variable
    private var viewModel: SearchViewModelProtokol
    private var coordinator: Coordinator
    
    // MARK: - UI Components
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let searchNewsCollectionView: UICollectionView = {
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
         viewModel: SearchViewModelProtokol) {
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
        setupNavigationBar()
        setupSearchController()
        setupUI()
        setSearchCollectionViewLayout()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(searchNewsCollectionView)
        
        NSLayoutConstraint.activate([
            searchNewsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchNewsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            searchNewsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchNewsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
            
    }
    
    // MARK: - SearchController
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Type the word you want to search..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    // MARK: - SearchCollectionViewLayout
    private func setSearchCollectionViewLayout() {
        searchNewsCollectionView.delegate = self
        searchNewsCollectionView.dataSource = self
        searchNewsCollectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: NewsCollectionViewCell.identifier)
    }
    // MARK: - NavigationBar
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Search"
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .label
        
        // MARK: - Sol Logo
        let logoImageView = UIImageView(image: UIImage(systemName: "newspaper.fill"))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.layer.cornerRadius = 6
        logoImageView.clipsToBounds = true
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        let logoItem = UIBarButtonItem(customView: logoImageView)
        navigationItem.leftBarButtonItem = logoItem
    }
}
// MARK: - Extension

// MARK: - SearchViewModelOutputProtokol
extension SearchViewController: SearchViewModelOutputProtokol {
    func updateCollectionView() {
        DispatchQueue.main.async {
            self.searchNewsCollectionView.reloadData()
        }
    }
}

// MARK: - Searchbar Methods
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.isActive {
            viewModel.getSearchNewsData(q: searchController.searchBar.text ?? "")
        } else {
            viewModel.clearSearchArticles()
        }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.searchArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = searchNewsCollectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.identifier, for: indexPath) as? NewsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: viewModel.searchArticles[indexPath.item])
        return cell
    }
}
