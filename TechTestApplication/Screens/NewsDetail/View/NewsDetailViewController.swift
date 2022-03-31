//
//  NewsDetailViewController.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 28/03/22.
//

import Foundation
import WebKit

class NewsDetailViewController: BaseViewController{    
    // MARK: Properties
    @IBOutlet private var webView: WKWebView!
    
    @IBOutlet private var animator: UIActivityIndicatorView!
    
    lazy var viewModel: NewsDetailViewModelProtocol = {
        NewsDetailViewModel(newsURL: "")
    }() as NewsDetailViewModelProtocol
    
    // Dependency injection through methods
    static func create(model: NewsDetailViewModelProtocol) -> NewsDetailViewController? {
        let storyboard = UIStoryboard(name: Constants.StoryboardXIBNames.main, bundle: nil)
        let vc = storyboard.instantiateViewController(
            withIdentifier: Constants.StoryboardXIBNames.newsDetailViewController)as? NewsDetailViewController
        vc?.viewModel = model
        return vc
    }
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureViewModel()
        webView.navigationDelegate = self
    }
    
    private func configureView() {
        animator.startAnimating()
        setNavigationAppearance(title: Constants.Titles.newsDetailTitle)
    }
    
    private func configureViewModel() {
        do{
            let webViewURL = try viewModel.fetchWebViewURLToLoad()
            self.webView.load(URLRequest(url: webViewURL))
        }
        catch{
            DispatchQueue.main.async {
                Alert.present(title: error.localizedDescription, message: "", actions: .ok(handler: {
                }), from: self)
            }
        }
    }
}

extension NewsDetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.async {
            self.animator.stopAnimating()
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        DispatchQueue.main.async {
            self.animator.stopAnimating()
        }
    }
}
