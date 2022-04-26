//
//  ViewController.swift
//  FlashNews
//
//  Created by Ali Jafarov on 26.04.22.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }

let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=485f5c1b855b49ef885b92891534f919")
    
    
    func getData(){ AF.request("https://newsapi.org/v2/top-headlines?country=us&apiKey=485f5c1b855b49ef885b92891534f919").responseJSON { result in
        print(result)
        
        
        }
    }
    
}


