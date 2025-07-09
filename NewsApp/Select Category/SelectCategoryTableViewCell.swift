//
//  SelectCategoryTableViewCell.swift
//  NewsApp
//
//  Created by Хасан Магомедов on 18.01.2024.
//

import UIKit

final class SelectCategoryTableViewCell: UITableViewCell {

    static let identifier = "SelectCategoryTableViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
        
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(titleLabel)
        
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    func configure(title: String, isActive: Bool) {
        titleLabel.text = title
        
        if isActive {
            titleLabel.textColor = Colors.actionRed
        } else {
            titleLabel.textColor = .black
        }
    }
}
