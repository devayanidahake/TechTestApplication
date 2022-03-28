//
//  NewsViewController.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 24/03/22.
//

import Foundation
import UIKit


class NewsViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var animator: UIActivityIndicatorView!
    
    lazy var viewModel: NewsViewModelProtocol = {
        NewsViewModel()
    }() as NewsViewModelProtocol
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
    }
    
    fileprivate func setTableViewProperties() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .lightGray
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView()
        tableView.allowsSelection = false
        tableView.register(NewsCell.nib, forCellReuseIdentifier: NewsCell.identifier)
    }
    
    fileprivate func initView() {
        setTableViewProperties()
        animator.startAnimating()
        self.navigationItem.title = Constants.Titles.newsListTitle
    }
    
    fileprivate func initViewModel() {
        viewModel.showAnimator = { [weak self] (showAnimator) in
            //TODO: Need to use async await for clean code
            DispatchQueue.main.async {
                showAnimator ? self?.animator.startAnimating():self?.animator.stopAnimating()
            }
        }
        
        // Show network error message
        viewModel.showAPIError = { [weak self](APIError) in
            DispatchQueue.main.async {
                guard let sourceVC = self else{return}
                Alert.present(title: APIError.errorDescription, message: "", actions: .ok(handler: {
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
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        90 // approx
    }
}

// MARK: - UITableViewDataSource

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as? NewsCell else { fatalError("xib does not exists") }
        // cell  will be created with CellVM data
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
}

