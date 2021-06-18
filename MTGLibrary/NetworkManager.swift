//
//  NetworkManager.swift
//  MTGLibrary
//
//  Created by Pritesh Nadiadhara on 3/16/21.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager() // Singleton
    // API docs found @ https://scryfall.com/docs/api/cards/collector
    // NOTE: API REQUIRES SETCODE LOWERCASED AND SETNUMBER W/O LEADING ZEROS
    private let baseURL = "https://api.scryfall.com/cards/"
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    typealias completionHandler = (Result<MTGCard, MTGError>) -> Void
    
    func getCards(for setCode: String, setNumber: String, completed: @escaping(Result<MTGCard, MTGError>) -> Void) {
        let endPoint = baseURL + "\(setCode)/\(setNumber)"
        print("constructed API Request url: " + endPoint)
        guard let url = URL(string: endPoint) else {
            completed(Result.failure(.invalidCardSetCode))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(Result.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(Result.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(Result.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let mtgcard = try decoder.decode(MTGCard.self, from: data)
                completed(Result.success(mtgcard))
            } catch {
                completed(Result.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        task.resume()
        
    }
}
