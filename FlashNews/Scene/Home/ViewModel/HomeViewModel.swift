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
    
    func getHomeData(searchText: String, complete: @escaping()->()) {
        CoreRequest.shared.getSearchedNews(text: searchText) { [weak self] response in
            if let articles = response.articles {
                self?.items = articles
            }
            complete()
        } failure: { errorMessage in
            
        }
    }
}
