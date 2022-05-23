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
    let apiKey = "4a41f261620d4530a6722dc6270f4f78"
    
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
    
    func getCountryNews(with country: String, complete: @escaping(Home)->(), failure: @escaping(String)->()) {
        AF.request("\(baseURL)top-headlines?country=\(country)&apiKey=\(apiKey)").responseData { response in
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
    
    
    func getSelectedCategory(with category: String,  complete: @escaping(Home)->(), failure: @escaping(String)->()) {
        AF.request("\(baseURL)top-headlines?apiKey=\(apiKey)&category=\(category)").responseData { response in
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
    
    func getDefaultCategoryNews(complete: @escaping(Home)->(), failure: @escaping(String)->()) {
        AF.request("\(baseURL)top-headlines?sources=bbc-news&apiKey=\(apiKey)").responseData { response in
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
}
