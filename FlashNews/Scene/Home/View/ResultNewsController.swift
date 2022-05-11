//
//  ResultNewsController.swift
//  FlashNews
//
//  Created by Ali Jafarov on 30.04.22.
//

import Foundation
import UIKit
import WebKit

class ResultNewsController: UIViewController {
    var webView: WKWebView = {
        let viewWeb = WKWebView()
        return viewWeb
    }()
    
    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        webView.frame = view.bounds
        webView.load(URLRequest(url: URL(string: url)!))
    }
    
}
