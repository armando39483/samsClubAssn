//
//  ProductsPageViewController.swift
//  SamsClub
//
//  Created by Armando Gonzalez on 12/18/18.
//  Copyright © 2018 Armando Gonzalez. All rights reserved.
//

import UIKit

final class ProductsPageViewController: UIPageViewController {
    
    // MARK: - Properties
    
    private var viewModel: ProductViewModel!
    private var startingRow: Int = 0
    
    // MARK: - Initialization
    
    convenience init(viewModel: ProductViewModel, startingRow: Int! = 0) {
        self.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.viewModel = viewModel
        self.startingRow = startingRow
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.dataSource = self
        // this should actually never fail
        guard let vc = self.detailsVC(at: startingRow) else { return }
        self.setViewControllers([vc],
                                direction: .forward,
                                animated: false,
                                completion: nil)
    }
    
    // MARK: - Helper
    
    /// Make each new VC, setup with information, or return nil
    private func detailsVC(at: Int) -> ProductDetailsController? {
        if (at < 0) { return nil }
        if (at > self.viewModel.productCount - 1) { return nil }
        
        let vc = ProductDetailsController.newVC()
        vc.productInfo = self.viewModel.productInfo(at: at)
        self.viewModel.imageData(at: at) { (imageData) in
            vc.productImage = (imageData != nil) ? UIImage(data: imageData!) : nil
        }
        vc.view.tag = at
        return vc
    }

}

extension ProductsPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return self.detailsVC(at: viewController.view.tag - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return self.detailsVC(at: viewController.view.tag + 1)
    }
    
}
