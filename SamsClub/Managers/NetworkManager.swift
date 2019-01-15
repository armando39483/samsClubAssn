//
//  NetworkManager.swift
//  ItemsList
//
//  Created by Armando Gonzalez on 12/15/18.
//  Copyright © 2018 Armando Gonzalez. All rights reserved.
//

import Foundation

enum Result {
    case success(Data)
    case error(Error?)
}

class NetworkManager {
    
    // MARK: - Singleton
    
    static let shared = NetworkManager()
    
    // MARK: - Properties
    
    private let session = URLSession.shared
    
    private init() { }
    
    /**
     This function fetches products from the server.
     
    - Parameter page: This the page number that is being requested
    - Parameter productCount: This is the number of products to request
    - Parameter completion: A completion handler to do some work after fetching the products, It completes with an optional ProductContainer
    */
    func getProducts(page: Int,
                     productCount: Int,
                     completion: @escaping (ProductContainer?)->()) {
        let tempURL = ResourceURL.productsRequestURLString(pageNum: page, productCount: productCount)
        guard let url = URL(string: tempURL) else {
            completion(nil)
            return
        }
        self.performTask(url: url) { (result) in
            switch (result) {
            case .success(let value):
                do {
                    let decoder = JSONDecoder()
                    let productList = try decoder.decode(ProductContainer.self, from: value)
                    completion(productList)
                } catch let error {
                    print("Error fetching product list data - \(error)")
                    completion(nil)
                }
            case .error:
                completion(nil)
            }
        }
    }
    
    func getImage(productURLString: String, _ completion: @escaping (Data?)->()) {
        let imageURLString = ResourceURL.baseImageURL + productURLString
        if let image = ImageCache.getAsset(identifier: imageURLString) {
            completion(image)
            return
        }
        guard let url = URL(string: imageURLString) else {
            completion(nil)
            return
        }
        self.performTask(url: url) { (result) in
            switch (result) {
            case .success(let value):
                completion(value)
            case .error:
                completion(nil)
            }
        }
    }
    
    private func performTask(urlRequest: URLRequest, _ completion: @escaping (Result)->())  {
        session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Data task error - \(error)")
                completion(Result.error(error))
                return
            }
            if let response = response as? HTTPURLResponse {
                if (200 ..< 300) ~= response.statusCode {
                    if let safeData = data {
                        completion(Result.success(safeData))
                    } else {
                        completion(Result.error(nil))
                    }
                    return
                }
            }
            completion(Result.error(nil))
            }.resume()
    }
    
    private func performTask(url: URL, _ completion: @escaping (Result)->()) {
        let urlRequest = URLRequest(url: url)
        self.performTask(urlRequest: urlRequest, completion)
    }
    
}
