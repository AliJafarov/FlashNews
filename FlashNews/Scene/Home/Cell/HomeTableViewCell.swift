//
//  HomeTableViewCell.swift
//  FlashNews
//
//  Created by Ali Jafarov on 28.04.22.
//

import UIKit
import  SDWebImage

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var describtionLabel: UILabel!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func layoutSubviews() {
          super.layoutSubviews()
          //set the values for top,left,bottom,right margins
          let margins = UIEdgeInsets(top: 5, left: 3, bottom: 5, right: 3)
          contentView.frame = contentView.frame.inset(by: margins)
          contentView.layer.cornerRadius = 5
    }

}
