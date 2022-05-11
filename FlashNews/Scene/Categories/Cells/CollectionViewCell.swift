//
//  CollectionViewCell.swift
//  FlashNews
//
//  Created by Ali Jafarov on 05.05.22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var categoryLabels: UILabel!
    
    override var isSelected: Bool {
            didSet {
                contentView.backgroundColor = isSelected ? .red : .lightGray
            }
        }
    

    
}

