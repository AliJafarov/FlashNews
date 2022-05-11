//
//  HomeTableViewCell.swift
//  FlashNews
//
//  Created by Ali Jafarov on 28.04.22.
//

import UIKit
import SDWebImage

class HomeTableViewCell: UITableViewCell {
    @IBOutlet private weak var describtionLabel: UILabel!
    @IBOutlet private weak var newsTitleLabel: UILabel!
    @IBOutlet private weak var newsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        newsImage.layer.cornerRadius = 7
        let margins = UIEdgeInsets(top: 5, left: 3, bottom: 5, right: 3)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.layer.cornerRadius = 5
    }
    
    func configure(data: Article?) {
        newsImage.layer.cornerRadius = 8
        if let data = data {
            newsTitleLabel.text = data.title ?? ""
            describtionLabel.text = data.description ?? ""
            newsImage.sd_setImage(with: URL(string: data.urlToImage ?? ""), completed: nil)
        }
    }

}
