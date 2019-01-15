//
//  ProductList.swift
//  ItemsList
//
//  Created by Armando Gonzalez on 12/15/18.
//  Copyright © 2018 Armando Gonzalez. All rights reserved.
//

import Foundation

struct ProductContainer: Codable {
    var products: [Product]? = nil
    var totalProducts: Int = 0
    var pageNumber: Int = 0
    var pageSize: Int = 0
    var statusCode: Int = 0
    
    private enum CodingKeys: String, CodingKey {
        case products, totalProducts, pageNumber, pageSize, statusCode
    }
}
