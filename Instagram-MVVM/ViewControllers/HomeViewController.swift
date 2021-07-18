//
//  HomeViewController.swift
//  Instagram-MVVM
//
//  Created by Achraf Ameddah on 13/6/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    //View properties
    private var homeView = HomeView()
    private var postDescriptionView = HomeDescriptionView()
    private var dimmedView: UIView?
    private var imageCache = NSCache<NSString, UIImage>()
    //View model
    private var homeViewModel = [HomeViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView(homeView)
        setupViewModels()
        addDimmingView(dimmedView)
    }

    private func setupViewModels() {
        APIClient.shared.getPosts { result in
            switch result {
            case let .success(posts):
                var postsViewModel = [PostViewModel]()
                for (_,post) in posts.enumerated() {
                    postsViewModel.append(PostViewModel(postModel: post))
                }
                self.homeViewModel.append(.posts(models: postsViewModel))
                DispatchQueue.main.async {
                    self.homeView.userTableView.reloadData()
                }

            case let .failure(error):
                print(error)
            }
        }
        
        APIClient.shared.getStories { result in
            switch result {
            case let .success(stories):
                var storyViewModel = [StoryViewModel]()
                stories.forEach { story in
                    storyViewModel.append(StoryViewModel(storyModel: story))
                }
                self.homeViewModel.append(.storyCollectionView(models: storyViewModel, rows: storyViewModel.count))
                DispatchQueue.main.async {
                    self.homeView.userTableView.reloadData()
                }
            case let .failure(error):
                print(error)
            }
        }        
    }
}

// MARK: TableView DataSource
extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return homeViewModel.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch homeViewModel[section] {
        case .storyCollectionView:
            return 1
        case let .posts(models: postViewModel):
            return postViewModel.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch homeViewModel[indexPath.section] {
        case let .storyCollectionView(models: models, rows: rows):
            guard let homeViewStoryCell = tableView.dequeueReusableCell(withIdentifier: HomeViewStoryCell.cellIdentifier) as? HomeViewStoryCell else {
                return HomeViewStoryCell(style: .default, reuseIdentifier: HomeViewStoryCell.cellIdentifier)
            }
            homeViewStoryCell.config(with: models[indexPath.row], rows: rows)
            return homeViewStoryCell

        case let .posts(models: postViewModel):
            guard let homeViewPostCell = tableView.dequeueReusableCell(withIdentifier: HomeViewPostCell.cellIdentifier) as? HomeViewPostCell else {
                return HomeViewPostCell(style: .default, reuseIdentifier: HomeViewPostCell.cellIdentifier)
            }
            homeViewPostCell.config(with: postViewModel[indexPath.row])
            APIClient.shared.downloadImage(from: postViewModel[indexPath.row].imageURL, imageCache: imageCache) { result in
                switch result {
                case let .success(image):
                    DispatchQueue.main.async {
                        homeViewPostCell.setImage(image)
                    }
                case let .failure(error):
                    // TODO: Handle to show error here
                    print(error)
                }
            }

            return homeViewPostCell
        }
    }
}

// MARK: TableView Delegate
extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch homeViewModel[indexPath.section] {
        case .storyCollectionView:
            return 70
        case .posts:
            return 400
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? HomeViewPostCell {
            showAlertView(postDescriptionView)
            postDescriptionView.activityIndicator.startAnimating()
            if let imageURL = cell.imageUrl {
                print(imageURL)
                APIClient.shared.classifyImage(with: imageURL) { [weak self] result in
                    guard let self = self else { return }
                    self.postDescriptionView.isLoading(true)
                    switch result {
                    case let .success(imageClass):
                        DispatchQueue.main.async {
                            print("Image confidence is :", imageClass.confidence - 1.29)
                            self.postDescriptionView.isLoading(false)
                            self.postDescriptionView.titleLabel.text = imageClass.title
                            self.postDescriptionView.descriptionLabel.text = imageClass.description
                            self.postDescriptionView.priceLabel.text = imageClass.price
                            self.postDescriptionView.link = URL(string: imageClass.link)!
                        }
                    case let .failure(error):
                        print("network error", error)
                    }
                }
            } 
        }
    }
}

// MARK: Description view for the image classification

extension HomeViewController {
    private func setupView(_ subView: HomeView) {
        subView.frame = view.bounds
        subView.userTableView.dataSource = self
        subView.userTableView.delegate = self
        view.addSubview(subView)
        let image = #imageLiteral(resourceName: "logo")
        let tintImage = image.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: tintImage)
        imageView.tintColor = .label
        navigationItem.titleView = imageView
    }

    private func addDimmingView(_ dimmedView: UIView?) {
        self.dimmedView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        self.dimmedView?.backgroundColor = .black
        self.dimmedView?.alpha = 0.3

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideDimmedView(tapGestureRecognizer:)))
        self.dimmedView?.isUserInteractionEnabled = true
        self.dimmedView?.addGestureRecognizer(tapGestureRecognizer)

        self.dimmedView?.isHidden = true
        view.addSubview(self.dimmedView!)
    }

    private func showAlertView(_ infoView: UIView?) {
        if let dimmedView = dimmedView {
            postDescriptionView = HomeDescriptionView(frame: CGRect(x: view.bounds.width / 6, y: view.bounds.height / 4, width: view.bounds.width / 1.5, height: 250))
            view.addSubview(postDescriptionView)
            dimmedView.isHidden = false
            postDescriptionView.isHidden = false
        }
    }

    @objc
    private func hideDimmedView(tapGestureRecognizer: UITapGestureRecognizer) {
        dimmedView?.isHidden = true
        postDescriptionView.isHidden = true
    }
}
