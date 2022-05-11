//
//  SearchTableViewCell.swift
//  FlashNews
//
//  Created by Ali Jafarov on 05.05.22.
//

import Foundation
import UIKit


class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var searcLabel: UILabel!
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }
    
    
    func configure(data: Article?) {
        if let data = data {
            dateLabel.text = data.publishedAt ?? ""
            searcLabel.text = data.title ?? ""
            searchImageView.sd_setImage(with: URL(string: data.urlToImage ?? ""), completed: nil)
        }
    }
    
    
    
}
