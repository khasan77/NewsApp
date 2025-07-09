//
//  NewsInfoViewController.swift
//  NewsApp
//
//  Created by Хасан Магомедов on 28.12.2023.
//

import UIKit
import SafariServices

final class ArticleInfoViewController: UIViewController {
    
    private let mainView = ArticleInfoView()
    private let item: Article
    private let image: UIImage
    
    // MARK: - Init
    
    init(item: Article, image: UIImage) {
        self.item = item
        self.image = image
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lyfecycle
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = . white
        
        mainView.configure(image: image, title: item.title, description: item.description)
        mainView.isFavorite = FavoriteStorage.shared.contains(item)
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "square.and.arrow.up"),
            style: .plain, target: self,
            action: #selector(shareButtonTapped)
        )
        
        setupActions()
    }
    
    // MARK: - Private methods
    
    private func setupActions() {
        mainView.goToSourceButton.addTarget(self, action: #selector(goToSourceButtonTapped), for: .touchDown)
        mainView.addToFavoritesButton.addTarget(self, action: #selector(addToFavoritesButtonTapped), for: .touchDown)
    }
    
    @objc
    private func goToSourceButtonTapped() {
        let vc = SFSafariViewController(url: item.url)
        
        present(vc, animated: true)
    }
    
    @objc
    private func shareButtonTapped() {
        let vc = UIActivityViewController(
            activityItems: [
                image,
                item.title,
                "\n",
                "Подробнее по ссылке: \(item.url)"
            ],
            applicationActivities: nil
        )
        present(vc, animated: true)
    }
    
    @objc
    private func addToFavoritesButtonTapped() {
        mainView.isFavorite = !mainView.isFavorite
        FavoriteStorage.shared.handle(item)
    }
}
