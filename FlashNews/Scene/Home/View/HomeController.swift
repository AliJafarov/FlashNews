//
//  HomeController.swift
//  FlashNews
//
//  Created by Shamkhal Guliyev on 26.04.22.
//

import UIKit

class HomeController: UIViewController {

    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
    }
    
    func getData() {
        viewModel.getHomeData(searchText: "twitter") {
            //reload table or collectio views
        }
    }
}
