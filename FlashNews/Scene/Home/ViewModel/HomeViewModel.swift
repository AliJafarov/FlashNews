//
//  HomeViewModel.swift
//  FlashNews
//
//  Created by Shamkhal Guliyev on 26.04.22.
//

import Foundation
import Alamofire

class HomeViewModel {
    
    let countries = ["Turkey":"tr", "United States":"us", "Russia":"ru", "Czech Republic":"cz", "Belgium":"be", "Germany":"de", "Hungary":"hu","Japan":"jp", "Taiwan":"tw", "France":"fr"]
    
    var items = [Article]() //strong
    var countryItems = [Article]()
    var searchItems = [Article]()
    
    func getHomeData(completeGetData: @escaping()->()) {
        CoreRequest.shared.getHomeNews { [weak self] response in
            if let articles = response.articles {
                self?.items = articles
            }
            completeGetData()
        } failure: { errorMessage in
            print(errorMessage)
        }
    }
    
    
    func getCountryData(_ countryData: String, completeGetData: @escaping()->()) {
        CoreRequest.shared.getCountryNews(with: countryData) { [weak self] response in
            if let articles = response.articles {
                self?.countryItems = articles
            }
            completeGetData()
        } failure: { errorMessage in
            print(errorMessage)
        }
    }
    
    
    func getSearch (_ query: String, completion: @escaping () ->()){
        CoreRequest.shared.getSearchedNews(with: query) { response in
            if let searchedData = response.articles{
                self.searchItems = searchedData
                completion()
            }
        } failure: { error in
            print(error)
        }
    }
    
    
}
