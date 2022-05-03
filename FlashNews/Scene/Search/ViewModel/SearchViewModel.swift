//
//  SearchViewModel.swift
//  FlashNews
//
//  Created by Ali Jafarov on 30.04.22.
//

import Foundation

class SearchViewModel {
    
    var searchItems = [Article]()
    var businessCategory = [Article]()
    
    
    func getSearch (_ query: String, completion: @escaping () ->()){
        CoreRequest.shared.getSearchedNews(with: query) { response in
            if let searchedData = response.articles{
                self.searchItems = searchedData
                completion()
            }
        } failure: { error in
            
        }
    }
    
    func getBusinessData( completion: @escaping () ->()){
        CoreRequest.shared.getBusiness { response in
            if let businesData = response.articles{
                self.businessCategory = businesData
            }
        } failure: { error in
            
        }
    }
}
