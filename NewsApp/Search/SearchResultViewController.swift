//
//  SearchResultViewController.swift
//  NewsApp
//
//  Created by Хасан Магомедов on 22.01.2024.
//

import UIKit

final class SearchResultViewController: UIViewController {
    
    private let fetchedItems: [Article]
    private let imagesProvider: ImagesProvider

    private var searchedItems: [Article] = []
    
    // MARK: - UI Elements
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = Colors.mainColor
        tableView.separatorStyle = .none
        tableView.rowHeight = 120
        return tableView
    }()
    
    // MARK: - Init
    
    init(items: [Article], imagesProvider: ImagesProvider) {
        self.fetchedItems = items
        self.imagesProvider = imagesProvider
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.mainColor
        
        title = "Search"
        
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        
        navigationItem.hidesSearchBarWhenScrolling = false
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ArticleListTableViewCell.self, forCellReuseIdentifier: ArticleListTableViewCell.identifier)
        
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationItem.searchController?.isActive = true
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        setupTableViewLayout()
    }
    
    // MARK: - Private methods
    
    private func setupTableViewLayout() {
        view.addSubview(tableView)
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

// MARK: - UITableViewDataSource

extension SearchResultViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleListTableViewCell.identifier, for: indexPath) as? ArticleListTableViewCell else {
            fatalError("Can not dequeue ArticleListTableViewCell")
        }
        
        cell.selectionStyle = .none
        
        let item = searchedItems[indexPath.row]
        
        cell.selectionStyle = .none
        cell.configure(article: item, imagesProvider: imagesProvider)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SearchResultViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = searchedItems[indexPath.row]
        let image = imagesProvider.image(for: item.urlToImage) ?? UIImage()
        let vc = ArticleInfoViewController(item: item, image: image)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UISearchResultsUpdating

extension SearchResultViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
        searchedItems = fetchedItems.filter { item in
            item.title.lowercased().contains(
                text.lowercased()
            )
        }
        
        tableView.reloadData()
    }
}

// MARK: - UISearchBarDelegate

extension SearchResultViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        navigationController?.popViewController(animated: true)
    }
}
