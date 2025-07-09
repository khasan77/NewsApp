//
//  NewsListViewController.swift
//  NewsApp
//
//  Created by Хасан Магомедов on 27.12.2023.
//

import UIKit

final class ArticleListViewController: UIViewController {

    private let dataController = ArticleListDataController()
    private let imagesProvider: ImagesProvider
    
    private var items: [Article] = []
    private var page = 1
    private var selectedCategory = Category.apple
    
    // MARK: - UI Elements
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = Colors.mainColor
        tableView.separatorStyle = .none
        tableView.rowHeight = 120
        return tableView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .large
        return activityIndicator
    }()
    
    private let customNavigationLeftView = SelectedCategoryView()
    
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

        view.backgroundColor = Colors.mainColor
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ArticleListTableViewCell.self, forCellReuseIdentifier: ArticleListTableViewCell.identifier)
        
        setupLayout()
        
        activityIndicator.startAnimating()
        
        fetchData()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .search,
            target: self,
            action: #selector(searchButtonTapped)
        )
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectedCategoryViewTapped))
        customNavigationLeftView.addGestureRecognizer(tapGesture)
        customNavigationLeftView.configure(title: selectedCategory.displayTitle)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customNavigationLeftView)
    }
    
    private func fetchData() {
        dataController.fetchData(q: selectedCategory.requestTitle, page: page) { [weak self] articles in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.items += articles
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
                self.tableView.tableFooterView = nil
                self.tableView.tableHeaderView = nil
            }
        }
    } 
    
    // MARK: - Layout
    
    private func setupLayout() {
        setupTableViewLayout()
        setupActivityIndicatorViewLayout()
    }
    
    // MARK: - Private methods
    
    @objc
    private func searchButtonTapped() {
        let vc = SearchResultViewController(items: items, imagesProvider: imagesProvider)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    private func selectedCategoryViewTapped() {
        let vc = SelectCategoryViewController(selectedItem: selectedCategory)
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    private func tableLoadingView() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 100))
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .large
        activityIndicator.startAnimating()
        
        view.addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return view
    }
    
    private func setupTableViewLayout() {
        view.addSubview(tableView)
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setupActivityIndicatorViewLayout() {
        view.addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

// MARK: - UITableViewDataSource

extension ArticleListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleListTableViewCell.identifier, for: indexPath) as? ArticleListTableViewCell else {
            fatalError("Can not dequeue ArticleListTableViewCell")
        }
        
        cell.selectionStyle = .none
        
        let item = items[indexPath.row]
        
        cell.selectionStyle = .none
        cell.configure(article: item, imagesProvider: imagesProvider)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ArticleListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        let image = imagesProvider.image(for: item.urlToImage) ?? UIImage()
        let vc = ArticleInfoViewController(item: item, image: image)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == items.count - 6 else  { return }
        
        tableView.tableFooterView = tableLoadingView()
        page += 1
        fetchData()
    }
}

// MARK: - SelectCategoryViewControllerDelegate

extension ArticleListViewController: SelectCategoryViewControllerDelegate {
    
    func doneButtonTapped(selectedCategory: Category) {
        if self.selectedCategory == selectedCategory {
            return 
        }
        
        self.selectedCategory = selectedCategory
         
        customNavigationLeftView.configure(title: selectedCategory.displayTitle)
        tableView.tableFooterView = tableLoadingView()
        items = []
        page = 1
        fetchData()
    }
}
