//
//  ResourceURL.swift
//  SamsClub
//
//  Created by Armando Gonzalez on 12/22/18.
//  Copyright © 2018 Armando Gonzalez. All rights reserved.
//

struct ResourceURL {
    static let baseURL = "https://mobile-tha-server.firebaseapp.com/walmartproducts/"
    static let baseImageURL = "https://mobile-tha-server.firebaseapp.com"
    
    static func productsRequestURLString(pageNum: Int, productCount: Int) -> String {
        return ResourceURL.baseURL + "\(pageNum)/\(productCount)"
    }
}
