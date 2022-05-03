//
//  SearchTableViewCell.swift
//  FlashNews
//
//  Created by Ali Jafarov on 30.04.22.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var searcLabel: UILabel!
    @IBOutlet weak var searchImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
