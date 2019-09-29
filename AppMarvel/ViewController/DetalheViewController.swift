//
//  DetalheViewController.swift
//  AppMarvel
//
//  Created by Lucas Mendes on 29/09/2019.
//  Copyright © 2019 lucas  mendes. All rights reserved.
//

import UIKit
import WebKit

class DetalheViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    var heroiSelecionado: Hero!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: heroiSelecionado.urls.first!.url) {
            let request = URLRequest(url: url)
            
            title = heroiSelecionado.name
            webView.load(request)
        }
        
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
    }

}

extension DetalheViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation:WKNavigation!) {
        loading.stopAnimating()
    }
}
