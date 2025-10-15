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
    private let bookmarkedNewsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        let numberOfColumns: CGFloat = 1
        let totalHorizontalPadding = layout.sectionInset.left + layout.sectionInset.right + (layout.minimumInteritemSpacing * (numberOfColumns - 1))
        let cellWidth = (UIScreen.main.bounds.width - totalHorizontalPadding) / numberOfColumns
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth * 0.5)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
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
        setupNavigationBar()
        setupCollectionView()
        setCollectionViewLayout()
        viewModel.getBookmarkArticles()
    }
    
    
    // MARK: - UI Setup
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Bookmarks"
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
    private func setupCollectionView() {
        view.backgroundColor = .systemBackground
        view.addSubview(bookmarkedNewsCollectionView)
        
        NSLayoutConstraint.activate([
            bookmarkedNewsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bookmarkedNewsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bookmarkedNewsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bookmarkedNewsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
            
    }
    private func setCollectionViewLayout() {
        bookmarkedNewsCollectionView.delegate = self
        bookmarkedNewsCollectionView.dataSource = self
        bookmarkedNewsCollectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: NewsCollectionViewCell.identifier)
    }
    
}

// MARK: - Extension

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension BookmarkViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.bookmarkArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = bookmarkedNewsCollectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.identifier, for: indexPath) as? NewsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: viewModel.bookmarkArticles[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator.eventOccurred(with: NewsDetailViewBuilder.build(coordinator: coordinator, news: viewModel.bookmarkArticles[indexPath.item]))
    }
}

// MARK: - BookmarkViewModelOutputProtokol
extension BookmarkViewController: BookmarkViewModelOutputProtokol {
    func updateCollectionView() {
        DispatchQueue.main.async {
            self.bookmarkedNewsCollectionView.reloadData()
        }
    }
    
}
