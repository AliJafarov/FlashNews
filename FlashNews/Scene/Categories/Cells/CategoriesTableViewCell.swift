//
//  CategoriesTableViewCell.swift
//  FlashNews
//
//  Created by Ali Jafarov on 06.05.22.
//

import UIKit

protocol TableViewCellDelegate {
    func didtaped(indexPath: IndexPath)
}

class CategoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    var delegate: TableViewCellDelegate?
    var indexPath: IndexPath!
  
    
    func configure(data: Article?) {
        newsImage.layer.cornerRadius = 7
        if let data = data {
            newsTitle.text = data.title ?? ""
            dateLabel.text = data.publishedAt ?? ""
            newsImage.sd_setImage(with: URL(string: data.urlToImage ?? ""), completed: nil)
        }
    }
    
    @IBAction func seeMoreButtonClicked(_ sender: Any) {
        delegate?.didtaped(indexPath: indexPath!)
        
        
    }
    
}
