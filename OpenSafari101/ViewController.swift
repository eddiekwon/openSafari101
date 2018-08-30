//
//  ViewController.swift
//  OpenSafari101
//
//  Created by eddiek on 28/08/2018.
//  Copyright © 2018 Eddie Kwon. All rights reserved.
//

import UIKit
import SafariServices
import WebKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // 1 launch safari then going to web page
    @IBAction func openSafari(_ sender: Any) {
        guard let url = URL(string: "http://www.stackoverflow.com") else { return }
        if #available(iOS 10.0 , *) {
            UIApplication.shared.open(url)
        }else{
            UIApplication.shared.openURL(url)
        }
    }
    
    func openYoutube(){
        guard let url = URL(string: "https://youtu.be/9bZkp7q19f0") else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    // 2 open webpage inside App.
    @IBAction func showSafariHere(_ sender: Any) {
         guard let url = URL(string: "http://www.stackoverflow.com") else { return }
        let svc = SFSafariViewController(url: url)
        present(svc , animated: true , completion: nil)
    }
    
    //3 open webpage, but cannot go back.
    @IBAction func useWKWebview(_ sender: Any) {
        loadWkWebview()
    }
    
    let webView = WKWebView()
    
}

extension ViewController:  WKNavigationDelegate{
    func loadWkWebview() {
        
        guard let url = URL(string: "https://www.google.com") else { return }
        webView.frame = view.bounds
        webView.navigationDelegate = self
        webView.load(URLRequest(url: url))
        webView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        view.addSubview(webView)
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated  {
            if let url = navigationAction.request.url,
                let host = url.host, !host.hasPrefix("www.google.com"),
                UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
                print(url)
                print("Redirected to browser. No need to open it locally")
                decisionHandler(.cancel)
            } else {
                print("Open it locally")
                decisionHandler(.allow)
            }
        } else {
            print("not a user click")
            decisionHandler(.allow)
        }
    }
}

