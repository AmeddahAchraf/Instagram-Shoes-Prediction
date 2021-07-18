//
//  HomeView.swift
//  Instagram-MVVM
//
//  Created by Achraf Ameddah on 13/6/2021.
//

import UIKit

class HomeView: UIView {
    
    let userTableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(HomeViewStoryCell.self, forCellReuseIdentifier: HomeViewStoryCell.cellIdentifier)
        tableView.register(HomeViewPostCell.self, forCellReuseIdentifier: HomeViewPostCell.cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupViews() {
        [userTableView].forEach { addSubview($0)}
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            userTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            userTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            userTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            userTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        
        ])
    }
}
