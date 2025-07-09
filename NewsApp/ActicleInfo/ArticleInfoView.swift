//
//  NewsInfoView.swift
//  NewsApp
//
//  Created by Хасан Магомедов on 28.12.2023.
//

import UIKit

final class ArticleInfoView: UIView {
    
    var isFavorite: Bool = false {
        didSet {
            updateAddToFavoritesButton()
        }
    }
    
    // MARK: - UI Elements
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 16
        imageView.isUserInteractionEnabled = true 
        imageView.clipsToBounds = true
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 18)
        textView.isScrollEnabled = false
        return textView
    }()
    
    let goToSourceButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Go to source", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        return button
    }()
    
    let addToFavoritesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    // MARK: - Init

    init() {
        super.init(frame: .zero)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        setupScrollViewLayout()
        setupContentViewLayout()
        setupImageViewLayout()
        setupTitleLabelLayout()
        setupDescriptionTextViewLayout()
        setupGoToSourceButtonLayout()
        setupAddToFavoritesLayout()
    }
    
    // MARK: - Private methods
    
    private func setupScrollViewLayout() {
        addSubview(scrollView)
        
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func setupContentViewLayout() {
        scrollView.addSubview(contentView)
        
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    private func setupImageViewLayout() {
        contentView.addSubview(imageView)
        
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 350).isActive = true
    }
    
    private func setupTitleLabelLayout() {
        contentView.addSubview(titleLabel)
        
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32).isActive = true
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32).isActive = true
    }
    
    private func setupDescriptionTextViewLayout() {
        contentView.addSubview(descriptionTextView)
        
        descriptionTextView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        descriptionTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32).isActive = true
    }
    
    private func setupGoToSourceButtonLayout() {
        contentView.addSubview(goToSourceButton)
        
        goToSourceButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        goToSourceButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 24).isActive = true
        goToSourceButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24).isActive = true
        goToSourceButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        goToSourceButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    private func setupAddToFavoritesLayout() {
        imageView.addSubview(addToFavoritesButton)
        
        addToFavoritesButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -24).isActive = true
        addToFavoritesButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -24).isActive = true
        addToFavoritesButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        addToFavoritesButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    private func updateDescription(_ text: String?) {
        
        guard let text = text else { return }
        
        descriptionTextView.text = text
    }
    
    private func updateAddToFavoritesButton() {
        if isFavorite {
            addToFavoritesButton.setBackgroundImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        } else {
            addToFavoritesButton.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
        }
    }
    
    func configure(image: UIImage, title: String, description: String) {
        imageView.image = image
        titleLabel.text = title
        
        updateDescription(description)
    }
}
