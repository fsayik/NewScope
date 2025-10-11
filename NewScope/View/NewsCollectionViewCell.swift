//
//  NewsCollectionViewCell.swift
//  NewScope
//
//  Created by Ferhat Şayık on 11.10.2025.
//

import UIKit
import Kingfisher

final class NewsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Variable
    static let identifier: String = "NewsCollectionViewCell"
    
    
    // MARK: - UI Components
    private let source: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray3
        label.numberOfLines = 1
        label.clipsToBounds = false
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 5
        label.clipsToBounds = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let publishedAt: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray3
        label.numberOfLines = 1
        label.clipsToBounds = false
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var stackView = {
        var stackView = UIStackView()
        stackView.backgroundColor = .secondarySystemBackground
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayer()
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
        source.text = nil
        title.text = nil
        publishedAt.text = nil
        image.image = nil
    }
    
    // MARK: - Configure Func
    func configure(with news: Article) {
        self.source.text = news.source?.name
        self.title.text = news.title
        self.publishedAt.text = news.publishedAt
        
        if let url = URL(string: news.urlToImage ?? "") {
            image.kf.setImage(with: url, placeholder: UIImage(systemName: "newspaper.fill"), options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        }
    }
    
    
    // MARK: - UI Setup
    private func setUpLayer() {
        stackView.layer.cornerRadius = 10
        stackView.layer.shadowColor = UIColor.label.cgColor
        stackView.layer.shadowOffset = CGSize(width: -4, height: 4)
        stackView.layer.shadowOpacity = 0.3
    }
    
    private func setUpUI() {
        contentView.addSubview(stackView)
        stackView.addSubViews(image, source, title, publishedAt)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            image.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.3),
            image.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            
            source.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            source.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10),
            
            title.topAnchor.constraint(equalTo: source.bottomAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            publishedAt.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -10),
            publishedAt.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10),
            
        ])
        
    }
    
    // MARK: - Extension
}
