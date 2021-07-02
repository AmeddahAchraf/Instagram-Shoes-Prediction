//
//  HomeCellCollectionView.swift
//  Instagram-MVVM
//
//  Created by Achraf Ameddah on 13/6/2021.
//

import UIKit

class HomeViewStoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "HomeViewStoryCollectionViewCell"
    
    let storyUserLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.text = "Story"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let storyImageView: UIImageView = {
        let v = UIImageView()
        v.layer.cornerRadius = 24
        v.contentMode = .scaleAspectFit
        v.image = UIImage(named: "logo")
        v.layer.borderWidth = 1
        v.layer.masksToBounds = false
        v.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(with viewModel: StoryViewModel) {
        self.storyImageView.image = viewModel.storyImage
        self.storyUserLabel.text = viewModel.storyLabel
    }
    
    private func setupViews() {
        [storyUserLabel, storyImageView].forEach { addSubview($0)}
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            storyImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -8),
            storyImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            storyImageView.heightAnchor.constraint(equalToConstant: 48),
            storyImageView.widthAnchor.constraint(equalToConstant: 48),
            
            storyUserLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            storyUserLabel.topAnchor.constraint(equalTo: storyImageView.bottomAnchor, constant: 4),
            storyUserLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
    }
    
    
}

