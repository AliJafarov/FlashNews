//
//  DownloadViewController.swift
//  FlashNews
//
//  Created by Ali Jafarov on 10.05.22.
//

import UIKit

class DownloadViewController: UIViewController {
    
    var  downloadVM = DownloadViewModel()
    
    
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
    

        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            getdata()
            tableView.reloadData()
        }
    
    
}

extension DownloadViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return downloadVM.downloadedNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as? DownloadTableViewCell else { return UITableViewCell() }
        cell.configure(data: downloadVM.downloadedNews[indexPath.row])
        
        return cell
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let modifyAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            DispatchQueue.main.async {
                self.showDeleteWarning(for: indexPath)
            }

            success(true)
        })

        modifyAction.image = UIImage(named: "delete")
        modifyAction.backgroundColor = .red

        return UISwipeActionsConfiguration(actions: [modifyAction])
    }

    func showDeleteWarning(for indexPath: IndexPath) {
        //Create the alert controller and actions
        let alert = UIAlertController(title: "Are you sure delete the news?", message: "", preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            DispatchQueue.main.async { [self] in
                
                DataPersistanceManager.shared.deleteNewsWith(model: downloadVM.downloadedNews[indexPath.row])
                self.downloadVM.downloadedNews.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }

        //Add the actions to the alert controller
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)

        //Present the alert controller
        present(alert, animated: true, completion: nil)
    }
    
    
    
}

