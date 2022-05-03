//
//  HeaderTableViewCell.swift
//  FlashNews
//
//  Created by Ali Jafarov on 29.04.22.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var headerIMageView: UIImageView!
    
    @IBOutlet weak var headerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
