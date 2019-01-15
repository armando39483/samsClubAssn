//
//  ProductTableViewCell.swift
//  SamsClub
//
//  Created by Armando Gonzalez on 12/17/18.
//  Copyright © 2018 Armando Gonzalez. All rights reserved.
//

import UIKit

final class ProductTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var price: UILabel!
    @IBOutlet private weak var rating: UILabel!
    @IBOutlet private weak var stock: UILabel!
    
    var productImage: UIImage? {
        set {
            self.productImageView.image = newValue
        }
        get {
            return self.productImageView.image
        }
    }
    
    // MARK: - Setup Method
    
    func setUpCell(with info: ProductInfo) {
        self.name.text = info.name
        self.rating.text = info.rating
        self.price.text = info.price
        self.stock.text = info.inStock
    }
}
