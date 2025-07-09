//  MainTabBarController.swift
//  NewsApp
//  Created by Хасан Магомедов on 28.12.2023.

import UIKit

final class MainTabBarController: UITabBarController {
    
    private let imagesProvider = ImagesProvider()
    
    private var newsListViewController: UINavigationController {
        let viewController = ArticleListViewControllerProvider.articleListViewController(imagesProvider: imagesProvider)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = UITabBarItem(
            title: "News",
            image: UIImage(systemName: "newspaper"),
            selectedImage: UIImage(systemName: "newspaper.fill")
        )
        navigationController.navigationBar.tintColor = .black
        return navigationController
    }
    
    private var favoriteNewsListViewController: UINavigationController {
        let viewController = FavoriteArticleListViewController(imagesProvider: imagesProvider)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = UITabBarItem(
            title: "Saved",
            image: UIImage(systemName: "bookmark"),
            selectedImage: UIImage(systemName: "bookmark.fill")
        )
        navigationController.navigationBar.tintColor = .black
        return navigationController
    }
    
    private var settingsViewController: UINavigationController {
        let viewController = SettingsViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "slider.vertical.3"),
            selectedImage: nil
        )
        return navigationController
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        
        viewControllers = [newsListViewController, favoriteNewsListViewController, settingsViewController]
        
        tabBar.tintColor = .red
        tabBar.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
