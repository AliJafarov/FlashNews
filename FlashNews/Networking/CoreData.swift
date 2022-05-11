//
//  CoreData.swift
//  FlashNews
//
//  Created by Ali Jafarov on 10.05.22.
//

import Foundation
import CoreData
import Alamofire


class DataPersistanceManager {
    
   static let shared = DataPersistanceManager()
    
    func downloadArticle(model: Article, completion: @escaping (Result<Void, Error >) -> Void ){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let item = NewsArticle(context: context)
        item.url = model.url
        item.describtion = model.description
        item.title = model.title
        item.publishedAt = model.publishedAt
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    
    
    func fetchingArticleFromDatabase(completion: @escaping(Result<[NewsArticle], Error >) -> Void) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            let request: NSFetchRequest<NewsArticle>
            request = NewsArticle.fetchRequest()
            do {
                let articles = try context.fetch(request)
                completion(.success(articles))
            } catch {
                completion(.failure(error))
            }
        }
    
    
}


