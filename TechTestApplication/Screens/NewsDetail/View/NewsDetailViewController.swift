//
//  NewsDetailViewController.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 28/03/22.
//

import Foundation
import WebKit

class NewsDetailViewController: BaseViewController {    
    // MARK: Properties
    @IBOutlet private var webView: WKWebView!
    
    @IBOutlet private var animator: UIActivityIndicatorView!
    
    private lazy var viewModel: NewsDetailViewModelProtocol = {
        NewsDetailViewModel(newsURL: "")
    }() as NewsDetailViewModelProtocol
    
    // Dependency injection through methods
    static func create(model: NewsDetailViewModelProtocol) -> NewsDetailViewController? {
        let storyboard = UIStoryboard(name: Constants.StoryboardXIBNames.main, bundle: nil)
        let viewController = storyboard.instantiateViewController(
            withIdentifier: Constants.StoryboardXIBNames.newsDetailViewController)as? NewsDetailViewController
        viewController?.viewModel = model
        return viewController
    }
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureViewModel()
        webView.navigationDelegate = self
    }
    
    private func configureView() {
        setNavigationAppearance(title: Constants.Titles.newsDetailTitle)
        animator.hidesWhenStopped = true
        shouldShowAnimator(show: true)
    }
    
    private func configureViewModel() {
        do {
            let webViewURL = try viewModel.fetchWebViewURLToLoad()
            self.webView.load(URLRequest(url: webViewURL))
        } catch {
            self.showApplicationAlert(self, alertTitle: error.localizedDescription)
        }
    }
    
    @MainActor
    private func showApplicationAlert(_ sourceVC: NewsDetailViewController, alertTitle: String) {
        shouldShowAnimator(show: false)
        Alert.present(title: alertTitle, message: "", actions: .okay(handler: {
        }), from: sourceVC)
    }
    
    func shouldShowAnimator(show: Bool) {
        if show {
            animator.startAnimating()
        } else {
            animator.stopAnimating()
        }
    }
}

extension NewsDetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.shouldShowAnimator(show: false)
    }
}
