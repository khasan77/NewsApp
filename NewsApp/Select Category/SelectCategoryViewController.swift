//
//  SelectCategoryViewController.swift
//  NewsApp
//
//  Created by Хасан Магомедов on 18.01.2024.
//

import UIKit

protocol SelectCategoryViewControllerDelegate: AnyObject {
    func doneButtonTapped(selectedCategory: Category)
}

final class SelectCategoryViewController: UIViewController {
    
    var delegate: SelectCategoryViewControllerDelegate?
    
    private let items = ["All news", "Tesla", "Apple"]
    
    private var selectedItem: Category
    
    // MARK: - UI Elements
    
    private let doneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Done", for: .normal)
        button.setTitleColor(Colors.actionRed, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 80
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Init
    
    init(selectedItem: Category) {
        self.selectedItem = selectedItem
        
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
        tableView.register(SelectCategoryTableViewCell.self, forCellReuseIdentifier: SelectCategoryTableViewCell.identifier)
        
        setupDoneButtonLayout()
        setupTableViewLayout()
        
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchDown)
    }
    
    // MARK: - Private methods
    
    private func setupDoneButtonLayout() {
        view.addSubview(doneButton)
        
        doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        doneButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
    }
    
    private func setupTableViewLayout() {
        view.addSubview(tableView)
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: CGFloat(Category.allCases.count * 80)).isActive = true
    }
    
    @objc
    private func doneButtonTapped() {
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.delegate?.doneButtonTapped(selectedCategory: self.selectedItem)
        }
    }
}

// MARK: - UITableViewDataSource

extension SelectCategoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Category.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectCategoryTableViewCell.identifier, for: indexPath) as? SelectCategoryTableViewCell else {
            fatalError("Can not dequeue SelectCategoryTableViewCell")
        }
        
        let item = Category.allCases[indexPath.row]
        let title = item.displayTitle
        
        cell.configure(title: title, isActive: selectedItem == item)
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SelectCategoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newItem = Category.allCases[indexPath.row]
        
        if newItem == selectedItem {
            return
        }
        
        selectedItem = newItem
        
        tableView.reloadData()
    }
}
