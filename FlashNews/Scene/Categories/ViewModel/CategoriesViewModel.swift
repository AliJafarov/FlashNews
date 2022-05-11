//
//  CategoriesViewModel.swift
//  FlashNews
//
//  Created by Ali Jafarov on 06.05.22.
//

import Foundation

class CategoriesViewModel {
    
    let categoryArray = ["business", "entertainment", "general", "health", "science", "sports", "technology"]
    var defaultNewsArray = [Article]()
    var selectedCategoryArray = [Article]()
    
    
    
    func getDefaultCategoryData(completeGetData: @escaping()->()) {
        CoreRequest.shared.getHomeNews { [weak self] response in
            if let articles = response.articles {
                self?.defaultNewsArray = articles
            }
            completeGetData()
        } failure: { errorMessage in
            print(errorMessage)
        }
    }
    
    
    func getSelectedCategoryData(_ categoryData: String, completeGetData: @escaping()->()) {
        CoreRequest.shared.getSelectedCategory(with: categoryData) { [weak self] response in
            if let articles = response.articles {
                self?.selectedCategoryArray = articles
            }
            completeGetData()
        } failure: { errorMessage in
            print(errorMessage)
        }
    }
    
    
    
    
    
    
}
