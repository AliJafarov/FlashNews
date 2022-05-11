//
//  DownloadViewController.swift
//  FlashNews
//
//  Created by Ali Jafarov on 10.05.22.
//

import UIKit

class DownloadViewController: UIViewController {
    
    let downloadVM = DownloadViewModel()
    
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        getdata()

    }
    
    
    private func getdata(){
        downloadVM.getDownloadedData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    
}

extension DownloadViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return downloadVM.downloadedNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as? DownloadTableViewCell else { return UITableViewCell() }
        cell.configure(data: downloadVM.downloadedNews[indexPath.row])
        
        return cell
    }
    
}

