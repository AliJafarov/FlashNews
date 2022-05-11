//
//  DownloadTableViewCell.swift
//  FlashNews
//
//  Created by Ali Jafarov on 11.05.22.
//

import UIKit

class DownloadTableViewCell: UITableViewCell {

   
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    
    
    
    func configure(data: NewsArticle?) {
        
        if let data = data {
            newsLabel.text = data.title
            dateLabel.text = data.publishedAt
        }
    }

}
