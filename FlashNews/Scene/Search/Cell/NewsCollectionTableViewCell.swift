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
    
    var newsItem: [News] = [News]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var collectionVM = SearchViewModel()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollectionview()
        print("2")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        let news1 = News(title: "Batman",    image: UIImage(named: "aa"))
        let news2 = News(title: "Spiderman", image: UIImage(named: "ss"))
        let news3 = News(title: "Sherlocks", image: UIImage(named: "hh"))
        self.newsItem.append(news1)
        self.newsItem.append(news2)
        self.newsItem.append(news3)
        print("5")
        print("\(newsItem[0].title)")
        }
    
    
    func setupCollectionview() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = layout
        self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    public func configure() {
             self.collectionView.reloadData()
     }
    
}


extension NewsCollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionViewCell
        
        print("3")

            cell.newsTitle.text = self.newsItem[indexPath.row].title
            cell.newsImage.image = self.newsItem[indexPath.row].image
        return cell

    }
    
}
