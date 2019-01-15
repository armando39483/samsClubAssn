//
//  ProductViewModel.swift
//  SamsClub
//
//  Created by Armando Gonzalez on 12/15/18.
//  Copyright © 2018 Armando Gonzalez. All rights reserved.
//

import Foundation

typealias ProductInfo = (name: String, desc: String, price: String, rating: String, inStock: String)

final class ProductViewModel {
 
    // MARK: - Properties
    
    private var productsList: [Product] = [Product]() {
        didSet {
            self.updateUI?()
        }
    }
    
    private var updateUI: (()->Void)?
    
    /// amount of items, per page, requested
    private var productsPerPage = 10
    
    // MARK: - Computed Properties
    
    /// the current page that we are on
    /// modulo 10 for indexing
    /// (1-indexed)
    var productPage: Int {
        return (productCount / productsPerPage) + 1
    }
    
    var productCount: Int {
        return productsList.count
    }
    
    // MARK: - Initialization
    
    init(updateCallback: (()->Void)?) {
        self.updateUI = updateCallback
    }
    
    // MARK: - Load More Products
    
    func loadNextProducts() {
        NetworkManager.shared.getProducts(page: productPage, productCount: productsPerPage) { [unowned self] productsContainer in
                                            guard let productsContainer = productsContainer else { return }
                                            if let products = productsContainer.products {
                                                self.productsList.append(contentsOf: products)
                                            }
        }
    }
    
    // MARK: - Individual Product Information Accessors
    
    func productInfo(at: Int) -> ProductInfo {
        let product = self.productsList[at]
        let name = product.productName
        let desc = product.longDescription
        let price = product.price
        let rating = String(format: "%.02f / 5", product.reviewRating)
        let inStock = product.inStock ? "In stock!" : "Not in stock."
        return (name: name, desc: desc, price: price, rating: rating, inStock: inStock)
    }
    
    /// Get image data, will be performed on main thread
    func imageData(at: Int, _ completion: @escaping (Data?)->Void){
        let product = self.productsList[at]
        NetworkManager.shared.getImage(productURLString: product.productImage) { (data) in
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
}
