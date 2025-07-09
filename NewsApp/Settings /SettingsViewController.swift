//
//  SettingsViewController.swift
//  NewsApp
//
//  Created by Хасан Магомедов on 11.01.2024.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Режим отображения карусели"
        return label
    }()
    
    private let actionSwitch: UISwitch = {
        let action = UISwitch()
        action.translatesAutoresizingMaskIntoConstraints = false
        return action
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Settings"
        
        view.backgroundColor = Colors.mainColor
    
        actionSwitch.isOn = UserDefaults.standard.bool(forKey: "actionSwitch")
        
        actionSwitch.addTarget(self, action: #selector(actionSwitchToggle), for: .valueChanged)
        
        setupTitleLabelLayout()
        setupActionSwitchLayout()
    }
    
    private func setupTitleLabelLayout() {
        view.addSubview(titleLabel)
        
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
    }
    
    private func setupActionSwitchLayout() {
        view.addSubview(actionSwitch)
        
        actionSwitch.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        actionSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true 
    }
    
    @objc
    private func actionSwitchToggle() {
        UserDefaults.standard.setValue(actionSwitch.isOn, forKey: "actionSwitch")
    }
}
