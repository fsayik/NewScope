//
//  NewsDetailViewController.swift
//  NewScope
//
//  Created by Ferhat Şayık on 13.10.2025.
//

import UIKit
import WebKit

final class NewsDetailViewController: UIViewController {
    
    // MARK: - Variable
    private var viewModel: NewsDetailViewModelProtokol
    private var coordinator: Coordinator
    
    
    // MARK: - UI Components
    private var webView: WKWebView!
    
    
    // MARK: - Init
    init(coordinator: Coordinator,
         viewModel: NewsDetailViewModelProtokol) {
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
        
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupWebView()
        loadWebsite()
    }
    
    // MARK: - UI Setup
    private func setupWebView() {
        webView = WKWebView(frame: .zero)
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .systemGray
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "arrowshape.forward.circle"), style: .plain, target: self, action: #selector(goForward)),
            UIBarButtonItem(image: UIImage(systemName: "arrow.trianglehead.clockwise"), style: .plain, target: self, action: #selector(reloadPage)),
            UIBarButtonItem(image: UIImage(systemName: "arrowshape.backward.circle"), style: .plain, target: self, action: #selector(goBack)),
            UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(addBookmark))
        ]
    }
    
    private func loadWebsite() {
        if let url = URL(string: (viewModel.newsDetail?.url)!) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    @objc private func reloadPage() {
        webView.reload()
    }
    
    @objc private func addBookmark() {
        viewModel.addToBookmarks()
    }
    
    @objc private func goBack() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @objc private func goForward() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    // MARK: - Extension
    
}
