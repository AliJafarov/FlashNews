//
//  HomeViewModel.swift
//  FlashNews
//
//  Created by Shamkhal Guliyev on 26.04.22.
//

import Foundation
import Alamofire

class HomeViewModel {
    var items = [Article]() //strong
    
    func getHomeData(completeGetData: @escaping()->()) {
        CoreRequest.shared.getHomeNews { [weak self] response in
            if let articles = response.articles {
                self?.items = articles
            }
            completeGetData()
        } failure: { errorMessage in
            
        }
    }
}
