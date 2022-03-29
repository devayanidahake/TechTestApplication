//
//  NewsViewController.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 24/03/22.
//

import Foundation
import UIKit


class NewsViewController: BaseViewController{
    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var animator: UIActivityIndicatorView!
    
    lazy var viewModel: NewsViewModelProtocol = {
        NewsViewModel.init(newsDataService: NewsDataService())
    }() as NewsViewModelProtocol
    
    //MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureViewModel()
    }
    
    private func configureView() {
        animator.startAnimating()
        setTableViewProperties()
        setNavigationAppearance(title: Constants.Titles.newsListTitle)
    }
    
    private func setTableViewProperties() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .lightGray
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView()
        tableView.allowsSelection = true
        tableView.register(NewsCell.nib, forCellReuseIdentifier: NewsCell.identifier)
    }
    
    private func configureViewModel() {
        
        // Get news data from VM
        Task{
            await self.viewModel.getNewsArray()
        }
        
        //All callbacks from view models
        // Show loader till list appears
        viewModel.showAnimator = { [weak self] (showAnimator) in
            //TODO: Need to use async await for clean code
            DispatchQueue.main.async {
                showAnimator ? self?.animator.startAnimating():self?.animator.stopAnimating()
            }
        }
        
        // Show network error message
        viewModel.showAPIError = { [weak self] error in
            DispatchQueue.main.async {
                guard let sourceVC = self else{return}
                Alert.present(title: error.localizedDescription, message: "", actions: .ok(handler: {
                }), from: sourceVC)
            }
        }

        // Reload TableView closure
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        // Navigate to detail screen
        viewModel.navigateToNewsDetailView = { [weak self] (newsURL) in
            
            let detailVM = NewsDetailViewModel.init(newsURL: newsURL)
            let detailVC = NewsDetailViewController.create(model: detailVM)
            
            self?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
// MARK: - UITableViewDelegate

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.Value.tableRowEstimatedHeight // estimated height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.setSelected(false, animated: true)
        self.viewModel.handleCellPressedAtIndex(index: indexPath.row)
    }
}

// MARK: - UITableViewDataSource

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as? NewsCell else { fatalError(Constants.ErrorMessages.xibNotFound) }
        // cell  will be created with CellVM data
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
}

