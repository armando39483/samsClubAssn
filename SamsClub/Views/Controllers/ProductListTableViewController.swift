//
//  ViewController.swift
//  SamsClub
//
//  Created by Armando Gonzalez on 12/15/18.
//  Copyright © 2018 Armando Gonzalez. All rights reserved.
//

import UIKit

class ProductListTableViewController: UIViewController {
    
    let identifier = "productCell"
    
    // MARK: - Outlets and UI
    
    @IBOutlet weak var tableView: UITableView!
    
    var activityView: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    var viewModel: ProductViewModel!
    var isFetchingData = false
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.initialLoadSetup()
        self.setupViewModel()
        self.fetchProducts()
    }
    
    // MARK: - Setup Methods
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = .red
        self.navigationController?.navigationBar.tintColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.title = "Products"
    }
    
    private func initialLoadSetup() {
        self.tableView.separatorStyle = .none
        self.activityView = UIActivityIndicatorView(frame: self.tableView.frame)
        self.activityView.style = .whiteLarge
        self.activityView.color = .red
        self.activityView.hidesWhenStopped = true
        self.activityView.startAnimating()
        self.tableView.backgroundView = self.activityView
    }
    
    private func setupViewModel() {
        let completion = { [unowned self] in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.isFetchingData = false
                self.activityView.startAnimating()
                self.tableView.separatorStyle = .singleLine
            }
        }
        self.viewModel = ProductViewModel(updateCallback: completion)
    }
    
    // MARK: - Helper Functions
    
    /// Fetch next group of products
    private func fetchProducts() {
        if (self.isFetchingData == true) { return }
        self.isFetchingData = true
        self.viewModel.loadNextProducts()
    }
}

/// This extension implements the proper methods to conform to UITableViewDelegate and UITableViewDataSource
extension ProductListTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.productCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                 for: indexPath) as! ProductTableViewCell
        let productInfo = self.viewModel.productInfo(at: row)
        cell.setUpCell(with: productInfo)
        self.viewModel.imageData(at: row) { (imageData) in
            cell.productImage = (imageData != nil) ? UIImage(data: imageData!) : nil
        }
        return cell
    }
    
    /// This function was implemented so that I could load the next batch of 10 products before the user scrolls to the end of the tableview
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == self.viewModel.productCount - 1) {
            self.fetchProducts()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tabBar = ProductsPageViewController(viewModel: self.viewModel, startingRow: indexPath.row)
        self.show(tabBar, sender: nil)
    }
    
}
