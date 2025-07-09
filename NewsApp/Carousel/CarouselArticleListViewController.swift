//
//  UpdatedArticleListViewController.swift
//  NewsApp
//
//  Created by Хасан Магомедов on 11.01.2024.
//

import UIKit

final class CarouselArticleListViewController: UIViewController {
    
    private let dataController = ArticleListDataController()
    private let imagesProvider: ImagesProvider
    
    private var page = 1
    private var items: [Article] = []
    
    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .large
        return activityIndicator
    }()
    
    // MARK: - Init
    
    init(imagesProvider: ImagesProvider) {
        self.imagesProvider = imagesProvider
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        collectionView.register(CarouselArticleListCollectionViewCell.self, forCellWithReuseIdentifier: CarouselArticleListCollectionViewCell.identifier)
        
        setupCollectionViewLayout()
        setupActivityIndicatorViewLayout()
        
        title = "News"
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        activityIndicator.startAnimating()
        
        fetchData()
    }
    
    // MARK: - Private methods
    
    private func fetchData() {
        dataController.fetchData(q: nil, page: page) { [weak self] articles in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.items += articles
                self.activityIndicator.stopAnimating()
                self.collectionView.reloadData()
            }
        }
    }
    
    private func setupCollectionViewLayout() {
        view.addSubview(collectionView)
        
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setupActivityIndicatorViewLayout() {
        view.addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

extension CarouselArticleListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CarouselArticleListCollectionViewCell.identifier,
                for: indexPath
        ) as? CarouselArticleListCollectionViewCell else {
            fatalError("Can not dequeue CarouselArticleListCollectionViewCell")
        }
        
        let item = items[indexPath.item]
        
        cell.configure(article: item, imagesProvider: imagesProvider)
        
        return cell
    }
}

extension CarouselArticleListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.size.width - 100, height: collectionView.bounds.size.height - 50)
    }
}

extension CarouselArticleListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        let image = imagesProvider.image(for: item.urlToImage) ?? UIImage()
        let vc = ArticleInfoViewController(item: item, image: image)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
