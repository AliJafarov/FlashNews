//
//  SearchViewController.swift
//  FlashNews
//
//  Created by Ali Jafarov on 30.04.22.
//

import UIKit

class SearchViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var vm = SearchViewModel()
    var categories: [String] = ["business", "entertainment", "general", "health", "science", "sports", "technology" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        hideKeyboard()
    }
    
    //    func setupCollectionview() {
    //        let layout = UICollectionViewFlowLayout()
    //                layout.itemSize = CGSize(width: 120, height: 170)
    //                layout.scrollDirection = .horizontal
    //                let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    //                collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: "NewsCell")
    //
    //    }
}

extension SearchViewController: UISearchBarDelegate {
    func hideKeyboard() {
        // To hide the keyboard
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        // This to make sure other things are still clickable after hiding keyboard
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchQueryText = searchBar.text!
        searchBar.endEditing(true)
        
        
        var properSearchQuery = ""
        for letter in searchQueryText {
            if letter == " " {
                properSearchQuery += "%20"
            }else {
                properSearchQuery += String(letter)
            }
        }
        let getStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let searchResultVC  = getStoryBoard.instantiateViewController(withIdentifier: "3") as! SearchResultViewController
        self.navigationController?.pushViewController(searchResultVC, animated: true)
        searchResultVC.getData(properSearchQuery)
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if searchBar.text != "" {
            return true
        } else {
            searchBar.placeholder = "Enter a search phrase"
            return false
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let searchText = (searchBar.text ?? "") + text
        
        if searchText.count > 2 {
            //TODO: call search api
            print("i am here")
        }
        
        return true
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section].capitalized
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCollectionTableviewCell", for: indexPath) as!
        NewsCollectionTableViewCell
        print("0")
        print("1")
        return cell
    }
}
