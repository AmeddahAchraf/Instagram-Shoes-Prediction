//
//  HomeDimmingView.swift
//  Instagram-MVVM
//
//  Created by Achraf Ameddah on 22/6/2021.
//

import UIKit

protocol HomeDescriptionViewDelegate: AnyObject {
    
}

class HomeDescriptionView: UIView {
    weak var delegate: HomeDescriptionViewDelegate?
    var link: URL?
    
    let activityIndicator: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView(style: .large)
        v.color = .red
        v.isHidden = false
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let loadingLabel: UILabel = {
        let v = UILabel()
        v.text = "Loading"
        v.textColor = .black
        v.font = .boldSystemFont(ofSize: 18)
        v.alpha = 0.9
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let titleLabel: UILabel = {
        let v = UILabel()
        v.text = ""
        v.textColor = .black
        v.isHidden = true
        v.font = .boldSystemFont(ofSize: 24)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let descriptionLabel: UILabel = {
        let v = UILabel()
        v.textColor = .black
        v.text = ""
        v.isHidden = true
        v.numberOfLines = 2
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let divider: UIView = {
        let v = UIView()
        v.backgroundColor = .gray
        v.isHidden = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let priceLabel: UILabel = {
        let v = UILabel()
        v.text = ""
        v.isHidden = true
        v.textColor = .black
        v.font = .boldSystemFont(ofSize: 18)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let shippingLabel: UILabel = {
        let v = UILabel()
        v.text = "Free Shipping"
        v.isHidden = true
        v.font = UIFont(name: "Avenir", size: 16)!
        v.textColor = .darkGray
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Buy Now", for: .normal)
        button.isHidden = true
        button.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9725490196, blue: 0, alpha: 1)
        button.tintColor = .black
        button.titleLabel?.font = UIFont(name: "Avenir", size: 17)!
        button.addTarget(self, action: #selector(submitButtonTapped), for: .touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        autoLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    func submitButtonTapped() {
        // Going to the website Screen programmatically
        if let link = link {
            UIApplication.shared.open(link)
        }
    }
    
    func isLoading(_ state: Bool) {
        DispatchQueue.main.async {
            if state {
                self.activityIndicator.isHidden = false
                self.loadingLabel.isHidden = false
            } else {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.loadingLabel.isHidden = true
                self.titleLabel.isHidden = false
                self.titleLabel.isHidden = false
                self.descriptionLabel.isHidden = false
                self.divider.isHidden = false
                self.priceLabel.isHidden = false
                self.shippingLabel.isHidden = false
                self.submitButton.isHidden = false
            }
        }
    }

    private func setupViews() {
        backgroundColor = .white
        alpha = 0.98
        layer.cornerRadius = 18
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchDown)
        [activityIndicator, loadingLabel, titleLabel, descriptionLabel, divider, priceLabel, shippingLabel, submitButton].forEach { addSubview($0) }
    }

    private func autoLayout() {
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),

            loadingLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 16),
            loadingLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            divider.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            divider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            divider.heightAnchor.constraint(equalToConstant: 1),
            
            priceLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            shippingLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            shippingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            shippingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            submitButton.widthAnchor.constraint(equalToConstant: 100),
            submitButton.heightAnchor.constraint(equalToConstant: 40),
            submitButton.topAnchor.constraint(equalTo: shippingLabel.bottomAnchor, constant: 16),
            submitButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            submitButton.centerXAnchor.constraint(equalTo: centerXAnchor),

        ])
    }
    
}
