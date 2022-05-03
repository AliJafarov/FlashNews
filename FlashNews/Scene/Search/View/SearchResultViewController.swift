//
//  SearchResultViewController.swift
//  FlashNews
//
//  Created by Ali Jafarov on 30.04.22.
//

import UIKit
import WebKit

class SearchResultViewController: UIViewController {
    
    public var  searchVM = SearchViewModel()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        print("SEARCH viewDidLoad")
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
     func getData(_ query: String){
            searchVM.getSearch(query) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
            }
        }
    }
}

extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let search = URL(string: searchVM.searchItems[indexPath.row].url ?? "" ) else { return }
        let vc = ResultSearchViewController()
        vc.webView.load(URLRequest(url: search))
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchVM.searchItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchTableViewCell else { fatalError() }
        cell.searcLabel.text = self.searchVM.searchItems[indexPath.row].title ?? ""
        if let searchImageUrl = URL(string: searchVM.searchItems[indexPath.row].urlToImage ?? "https://discountseries.com/wp-content/uploads/2017/09/default.jpg") {
            cell.searchImageView.sd_setImage(with: searchImageUrl, completed: nil)
        }
        return cell
    }
}
