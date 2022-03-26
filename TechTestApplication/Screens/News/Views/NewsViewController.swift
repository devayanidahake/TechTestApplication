//
//  NewsViewController.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 24/03/22.
//

import Foundation
import UIKit

let navigationTitle = "News"

class NewsViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var animator: UIActivityIndicatorView!
    
    lazy var viewModel = {
        NewsViewModel()
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
    }
    
    fileprivate func setTableViewProperties() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .white
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView()
        tableView.allowsSelection = false
        tableView.register(NewsCell.nib, forCellReuseIdentifier: NewsCell.identifier)
    }
    
    func initView() {
        setTableViewProperties()
        animator.startAnimating()
        self.navigationItem.title = navigationTitle
    }
    
    func initViewModel() {
        viewModel.showAnimator = { [weak self] (showAnimator) in
            DispatchQueue.main.async {
                showAnimator ? self?.animator.startAnimating():self?.animator.stopAnimating()
            }
        }
        
        // Show network error message
        viewModel.showNetworkError = { [weak self](networkError) in
            DispatchQueue.main.async {
                guard let sourceVC = self else{return}
                Alert.present(title: networkError.errorDescription, message: "", actions: .ok(handler: {
                    print("ok button pressed")
                }), from: sourceVC)
            }
        }

        // Get news data
        viewModel.getNewsArray()
        
        // Reload TableView closure
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
    }
    
    
}
// MARK: - UITableViewDelegate

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

// MARK: - UITableViewDataSource

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as? NewsCell else { fatalError("xib does not exists") }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        
        cell.textLabel?.text = cellVM.title
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.detailTextLabel?.text = cellVM.author
        return cell
    }
}

