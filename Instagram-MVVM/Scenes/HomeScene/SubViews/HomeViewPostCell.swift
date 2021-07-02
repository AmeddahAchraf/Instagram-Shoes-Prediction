//
//  HomeViewTableCell.swift
//  Instagram-MVVM
//
//  Created by Achraf Ameddah on 13/6/2021.
//

import UIKit

class HomeViewPostCell: UITableViewCell {
    static let cellIdentifier = "HomeViewPostCell"
    var imageUrl: URL?
    
    let postUserLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.text = "User"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postImageView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFill
        v.layer.masksToBounds = true
        v.image = UIImage(named: "logo")
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let profileImageView: UIImageView = {
        let v = UIImageView()
        v.layer.cornerRadius = 20
        v.contentMode = .scaleAspectFill
        v.image = UIImage(named: "logo")
        v.layer.borderWidth = 1
        v.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        v.layer.masksToBounds = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let likeLogoButton: UIButton = {
        let v = UIButton(type: .system)
        v.setImage(UIImage(systemName: "heart"), for: .normal)
        v.contentMode = .scaleAspectFit
        v.tintColor = .black
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let postCaptionLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 11)
        label.text = "User"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }
    
    override func prepareForReuse() {
        self.profileImageView.image = nil
        self.postUserLabel.text = ""
        self.postCaptionLabel.text = ""
        self.postImageView.image = nil
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(with model: PostViewModel) {
        prepareForReuse()
        self.postUserLabel.text = model.userName
        self.postCaptionLabel.text = "\(model.userName)" + ": \(model.caption)"
        self.imageUrl = URL(string: model.imageURL)!
    }
    
    func setImage(_ image: UIImage) {
        self.postImageView.image = image
        self.profileImageView.image = image
    }
    
    private func setupViews() {
        selectionStyle = .none
        [ likeLogoButton, postCaptionLabel, postUserLabel, profileImageView, postImageView].forEach { addSubview($0)}
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
           
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            
            postUserLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            postUserLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
            
            postImageView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
            postImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: 280),
            
            likeLogoButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 8),
            likeLogoButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            likeLogoButton.heightAnchor.constraint(equalToConstant: 20),
            likeLogoButton.widthAnchor.constraint(equalToConstant: 22),
            
            postCaptionLabel.topAnchor.constraint(equalTo: likeLogoButton.bottomAnchor, constant: 8),
            postCaptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            postCaptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            postCaptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
        ])
    }
}
