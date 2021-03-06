//
//  SearchResultViewController.swift
//  FlashNews
//
//  Created by Ali Jafarov on 30.04.22.
//

import UIKit
import WebKit

class SearchResultViewController: UIViewController {
    
    public var  searchVM = HomeViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
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
        let vc = ResultNewsController()
        vc.url = searchVM.searchItems[indexPath.row].url ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchVM.searchItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchTableViewCell else { fatalError() }
        cell.configure(data: searchVM.searchItems[indexPath.row])
        return cell
    }
}
