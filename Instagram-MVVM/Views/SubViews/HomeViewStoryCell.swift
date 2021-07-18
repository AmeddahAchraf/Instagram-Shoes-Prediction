//
//  HomeViewTableCell.swift
//  Instagram-MVVM
//
//  Created by Achraf Ameddah on 13/6/2021.
//

import UIKit

class HomeViewStoryCell: UITableViewCell {
    
    
    static let cellIdentifier = "HomeViewStoryCell"
    private var collectionView: UICollectionView
    private var storyModel: StoryViewModel?
    private var rows: Int?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
                 
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout.itemSize = CGSize(width: 60, height: 75)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeViewStoryCollectionViewCell.self, forCellWithReuseIdentifier: HomeViewStoryCollectionViewCell.identifier)
        
        contentView.addSubview(collectionView)
    }
      
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    func config(with model: StoryViewModel, rows: Int) {
        storyModel = model
        self.rows = rows
    }
 
}

extension HomeViewStoryCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let rows = rows else {
            return 0
        }
        return rows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let storyModel = storyModel ,let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeViewStoryCollectionViewCell.identifier, for: indexPath) as? HomeViewStoryCollectionViewCell else {
            return HomeViewStoryCollectionViewCell()
        }
        cell.config(with: storyModel)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

