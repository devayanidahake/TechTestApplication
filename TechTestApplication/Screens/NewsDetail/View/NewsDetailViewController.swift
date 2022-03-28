//
//  NewsDetailViewController.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 28/03/22.
//

import Foundation
import WebKit

class NewsDetailViewController: UIViewController{
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var animator: UIActivityIndicatorView!
    
    lazy var viewModel: NewsDetailViewModelProtocol = {
        NewsDetailViewModel(newsURLvalue: "")
    }() as NewsDetailViewModelProtocol
    
    static func create(model: NewsDetailViewModelProtocol) -> NewsDetailViewController {
        let storyboard = UIStoryboard(name: Constants.StoryboardXIBNames.main, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardXIBNames.newsDetailViewController)as! NewsDetailViewController
        vc.viewModel = model
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        webView.navigationDelegate = self
    }
    
    private func initView() {
        reloadWebView()
        animator.startAnimating()
        self.navigationItem.title = Constants.Titles.newsDetailTitle
    }
    
    private func reloadWebView() {
        let url = URL(string: viewModel.newsURL)!
        webView.load(URLRequest(url: url))
    }
}

extension NewsDetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        animator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        animator.stopAnimating()
    }
}
