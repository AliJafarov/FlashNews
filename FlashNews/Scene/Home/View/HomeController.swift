//
//  HomeController.swift
//  FlashNews
//
//  Created by Shamkhal Guliyev on 26.04.22.
//

import UIKit

class HomeController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = HomeViewModel()
    private var headerNews: NewsHeader?
        
    override func viewDidLoad() {
        super.viewDidLoad()
                
        headerNews = NewsHeader(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 270))
        tableView.tableHeaderView = headerNews
        
        getData()
    }
    
    func getData() {
        viewModel.getHomeData() {
//            DispatchQueue.main.async {}
            
            self.headerNews?.configure(data: self.viewModel.items.randomElement())
            self.tableView.reloadData()
        }
    }
}

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = ResultNewsController()
        vc.url = viewModel.items[indexPath.row].url ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as? HomeTableViewCell else { fatalError() }
        cell.configure(data: viewModel.items[indexPath.row])
        return cell
    }
}
