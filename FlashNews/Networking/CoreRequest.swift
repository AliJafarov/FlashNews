//
//  CoreRequest.swift
//  FlashNews
//
//  Created by Shamkhal Guliyev on 26.04.22.
//

import Foundation
import Alamofire

class CoreRequest {
    static let shared = CoreRequest()
    
    let baseURL = "https://newsapi.org/v2"
    let apiKey = "485f5c1b855b49ef885b92891534f919"
    
    func getSearchedNews(text: String, complete: @escaping(SearchNews)->(), failure: @escaping(String)->()) {
        AF.request("\(baseURL)/everything?q=\(text)").responseData { response in
            if let data = response.data {
                do {
                    let searchResult = try JSONDecoder().decode(SearchNews.self, from: data)
                    complete(searchResult)
                } catch {
                    failure(error.localizedDescription)
                }
            }
        }
    }
}
