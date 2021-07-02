//
//  APIClient.swift
//  PreparingInterview
//
//  Created by Achraf Ameddah on 16/6/2021.
//

import Firebase
import Foundation

class APIClient {
    static let shared = APIClient()
    
    var baseURL = "http://127.0.0.1:5000/"
    var firebaseRefChild = "FeedPosts/asdfasdf"

    private var ref: DatabaseReference = Database.database().reference()

    func getPosts(completion: @escaping (Result<[PostModel], NetworkError>) -> Void) {
        ref.child(firebaseRefChild).getData { error, snapshot in
            if let _ = error {
                completion(.failure(.badResponse))
            } else if let value = snapshot.value as? [String: Any] {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                    let posts = try JSONDecoder().decode([String: PostModel].self, from: jsonData)
                    completion(.success(Array(posts.values.map { $0 })))
                } catch {
                    completion(.failure(.invalidJSONObject))
                }
            } else {
                completion(.failure(.badResponse))
            }
        }
    }
    
    func getStories(completion: @escaping (Result<[StoryModel], NetworkError>) -> Void) {
        var stories = [StoryModel]()
        for _ in 0...10 {
            stories.append(StoryModel(storyImage: UIImage(named: "logo")!, storyLabel: "random"))
        }
        completion(.success(stories))
    }

    func classifyImage(with link: URL, completion: @escaping (Result<ImageClass, NetworkError>) -> Void) {
        if let url = URL(string: baseURL + "image?link=\(link)") {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let _ = error {
                    completion(.failure(.badResponse))
                }
                if let data = data {
                    do {
                        let decodedData = try JSONDecoder().decode(ImageClass.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        completion(.failure(.invalidJSONObject))
                    }
                }
            }.resume()
        } else {
            completion(.failure(.invalidURL))
        }
    }
    
    func downloadImage(from urlString: String, imageCache: NSCache<NSString, UIImage> , _ completion: @escaping ((Result<UIImage, NetworkError>) -> Void)) {
        if let url = URL(string: urlString) {
            if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
                completion(.success(imageFromCache))
                return
            }
            DispatchQueue.global(qos: .background).async {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        imageCache.setObject(image, forKey: urlString as NSString)
                        completion(.success(image))
                    }
                } else {
                    completion(.failure(.invalidJSONObject))
                }
            }
        } else {
            completion(.failure(.invalidURL))
        }
    }
    
}
