//
//  NewsCollectionTableViewCell.swift
//  FlashNews
//
//  Created by Ali Jafarov on 02.05.22.
//

import UIKit

struct News {
    let title: String?
    let image: UIImage?
}

class NewsCollectionTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var collectionVM = SearchViewModel()
    var newsItem = [News(title: "Batman",    image: UIImage(named: "aa")),
                    News(title: "Spiderman", image: UIImage(named: "ss")),
                    News(title: "Sherlocks", image: UIImage(named: "hh"))]
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
        
    public func configure() {
        collectionView.reloadData()
    }
}

extension NewsCollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionViewCell
        cell.newsTitle.text = newsItem[indexPath.row].title
        cell.newsImage.image = newsItem[indexPath.row].image
        return cell        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 130, height: 180)
    }
}
