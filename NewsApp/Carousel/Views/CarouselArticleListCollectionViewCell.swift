//
//  UpdatedArticleListCollectionViewCell.swift
//  NewsApp
//
//  Created by Хасан Магомедов on 13.01.2024.
//

import UIKit

final class CarouselArticleListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CarouselArticleListCollectionViewCell"
    
    // MARK: - UI Elements
    
    private let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 2
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        articleImageView.image = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        setupArticleImageViewLayout()
        setupTitleLabelLayout()
        setupDescriptionLabelLayout()
    }
    
    private func setupArticleImageViewLayout() {
        contentView.addSubview(articleImageView)
        
        articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        articleImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        articleImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8).isActive = true
    }
    
    private func setupTitleLabelLayout() {
        contentView.addSubview(titleLabel)
        
        titleLabel.leadingAnchor.constraint(equalTo: articleImageView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: articleImageView.trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 16).isActive = true
    }
    
    private func setupDescriptionLabelLayout() {
        contentView.addSubview(descriptionLabel)
        
        descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
    }
    
    func configure(article: Article, imagesProvider: ImagesProvider) {
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        
        imagesProvider.image(for: article.urlToImage) { [weak self] image in
            DispatchQueue.main.async {
                self?.articleImageView.image = image
            }
        }
    }
}
