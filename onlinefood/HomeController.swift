//
//  HomeController.swift
//  onlinefood
//
//  Created by John Nik on 18/04/2018.
//  Copyright © 2018 John Nik. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class HomeController: UIViewController {
    
    var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoad()
    }
    
    func setupLoad() {
        
        webView = UIWebView(frame: self.view.bounds)
        webView.scrollView.bounces = false
        webView.delegate = self
        self.view = webView
        
        guard let url = URL(string: "https://dev.onlinefood.gr/elink") else { return }
        let request = URLRequest(url: url)
        webView.loadRequest(request)
        
    }
}

extension HomeController: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        guard ReachabilityManager.shared.internetIsUp else {
            self.showJHTAlerttOkayWithIcon(message: "Oops, looks like something is wrong with your Internet")
            return }
        SVProgressHUD.show(withStatus: "Loading...")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        SVProgressHUD.dismiss()
        
    }
    
}

extension UIColor {
    
    static var defaultColor = UIColor(red: 91.0/255.0, green: 145.0/255.0, blue: 218.0/255.0, alpha: 1.0)
}
