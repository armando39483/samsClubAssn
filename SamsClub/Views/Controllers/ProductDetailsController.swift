//
//  ProductDetailsController.swift
//  SamsClub
//
//  Created by Armando Gonzalez on 12/18/18.
//  Copyright © 2018 Armando Gonzalez. All rights reserved.
//

import UIKit

final class ProductDetailsController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var availabilityLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK: - Properties
    
    var productImage: UIImage? {
        set {
            self.imageView.image = newValue
        }
        get {
            return self.imageView.image
        }
    }
    
    var productInfo: ProductInfo?
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.scrollView.contentOffset = .zero
    }

    // MARK: - Helper Functions
    
    func setUpNavigationBar() {
        let barButton = UIBarButtonItem(barButtonSystemItem: .done,
                                        target: self,
                                        action: #selector(ProductDetailsController.dismissVC))
        barButton.tintColor = .white
        self.navigationItem.setLeftBarButton(barButton, animated: false)
        guard let info = productInfo else { return }
        self.title = info.name
    }
    
    @objc func dismissVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helper Functions
    
    private func setUpView() {
        guard let info = productInfo else { return }
        self.nameLabel.text = info.name
        self.ratingLabel.text = info.rating
        self.priceLabel.text = info.price
        self.availabilityLabel.text = "Availability: \(info.inStock)"
        self.descriptionLabel.attributedText = info.desc.convertToAttributedString()
    }
}

extension ProductDetailsController {
    static func newVC() -> ProductDetailsController {
        return UIStoryboard.main().instantiateViewController(withIdentifier: "ProductDetailsController") as! ProductDetailsController
    }
}
