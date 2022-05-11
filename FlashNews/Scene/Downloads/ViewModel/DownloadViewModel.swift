//
//  DownloadViewModel.swift
//  FlashNews
//
//  Created by Ali Jafarov on 11.05.22.
//

import Foundation

class DownloadViewModel {
    
    var downloadedNews = [NewsArticle]()
    
    
    func getDownloadedData(completion: @escaping ()->()) {
        DataPersistanceManager.shared.fetchingArticleFromDatabase { result in
            switch result {
            case.success(let articles):
                self.downloadedNews = articles
            case.failure(let error):
                print(error.localizedDescription)
        }
    }
}

    
    
    
}
