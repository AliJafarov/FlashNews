//
//  ResultSearchViewController.swift
//  FlashNews
//
//  Created by Ali Jafarov on 01.05.22.
//

import UIKit
import WebKit

class ResultSearchViewController: UIViewController {

    var webView: WKWebView = {
        let viewWeb = WKWebView()
        return viewWeb
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        webView.frame = view.bounds
    }
}
