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
    
    let baseURL = "https://newsapi.org/v2/"
    let apiKey = "a2a9accb37ba4bd9a7e99f10c3bdffc7"
    
    func getHomeNews(complete: @escaping(Home)->(), failure: @escaping(String)->()) {
        AF.request("\(baseURL)top-headlines?country=us&apiKey=\(apiKey)").responseData { response in
            if let data = response.data {
                do {
                    let homeResult = try JSONDecoder().decode(Home.self, from: data)
                    complete(homeResult)
                } catch {
                    failure(error.localizedDescription)
                }
            }
        }
    }
    
    
    func getSearchedNews(with query: String, complete: @escaping(Home)->(), failure: @escaping(String)->()) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        else {return}
        AF.request("\(baseURL)everything?q=\(query)&apiKey=\(apiKey)").responseData { response in
            if let data = response.data {
                do {
                    let searchResult = try JSONDecoder().decode(Home.self, from: data)
                    complete(searchResult)
                } catch {
                    failure(error.localizedDescription)
                }
            }
        }
    }
    
    
    func getBusiness(complete: @escaping(Home)->(), failure: @escaping(String)->()) {
        AF.request("\(baseURL)top-headlines?country=us&apiKey=\(apiKey)&category=business").responseData { response in
            if let data = response.data {
                do {
                    let homeResult = try JSONDecoder().decode(Home.self, from: data)
                    DispatchQueue.main.async {
                    complete(homeResult)
                    }
                } catch {
                    failure(error.localizedDescription)
                }
            }
        }
    }
    
    
}
