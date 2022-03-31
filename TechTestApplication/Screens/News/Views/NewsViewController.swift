//
//  NewsViewController.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 24/03/22.
//

import Foundation
import UIKit


class NewsViewController: BaseViewController{
    // MARK: Properties
    @IBOutlet private var tableView: UITableView!
    
    @IBOutlet private var animator: UIActivityIndicatorView!
    
    lazy var viewModel: NewsViewModelProtocol = {
        NewsViewModel(newsDataService: NewsDataService(withNetworkManager: NetworkManager()))
    }() as NewsViewModelProtocol
    
    // MARK: Methods
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
        
        fetchNewsFeed()
        
        // All callbacks from view models
        handleDataLoader()
        
        handleErrorNotification()
        
        handleTableviewRefreshActivity()
        
        handleNavigationToDetailScreen()
    }
}

extension NewsViewController{
    private func fetchNewsFeed() {
        // Get news data from VM
        Task{[weak self] in
            await self?.viewModel.getNewsArray()
        }
    }
    
    private func handleDataLoader() {
        // Show loader till list appears
        viewModel.shouldShowAnimator = { [weak self] (showLoader) in
            Task{[weak self] in
                self?.showDataLoader(show: showLoader)
            }
        }
    }
  
    private func handleErrorNotification() {
        // Show network error message
        viewModel.showAPIError = { [weak self] error in
            Task{[weak self] in
                guard let sourceVC = self else{return}
                
                self?.showApplicationAlert(sourceVC, alertTitle: error.localizedDescription)
            }
        }
    }
    
    private func handleTableviewRefreshActivity() {
        // Reload TableView closure
        viewModel.reloadTableView = { [weak self] in
            Task{[weak self] in
                self?.reloadTableView()
            }
        }
    }
    
    private func handleNavigationToDetailScreen() {
        // Navigate to detail screen
        viewModel.navigateToNewsDetailView = { [weak self] (newsURL) in
            
            let detailVM = NewsDetailViewModel(newsURL: newsURL)
            guard let detailVC = NewsDetailViewController.create(model: detailVM) else{return}
            
            self?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    // MARK: UI update operations done using Mainactor on main thread
    @MainActor
    private func reloadTableView() {
        self.tableView.reloadData()
    }
    
    @MainActor
    private func showDataLoader(show: Bool) {
        if(show){
            self.animator.startAnimating()
        }
        else{
            self.animator.stopAnimating()
        }
    }
    
    @MainActor
    private func showApplicationAlert(_ sourceVC: NewsViewController, alertTitle: String) {
        Alert.present(title: alertTitle, message: "", actions: .ok(handler: {
        }), from: sourceVC)
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
