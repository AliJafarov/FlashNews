//
//  HomeController.swift
//  FlashNews
//
//  Created by Shamkhal Guliyev on 26.04.22.
//

import UIKit
import SDWebImage

class HomeController: UIViewController {
    
    private var headerNews: NewsHeader?
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = HomeViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getData()
        headerNews = NewsHeader(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 270))
        tableView.tableHeaderView = headerNews
    }
    
    func getData() {
        viewModel.getHomeData() {
            DispatchQueue.main.async {
                let headerData = self.viewModel.items.randomElement()
                self.headerNews?.headerLabel.text = headerData?.title ?? ""
                let headerImageUrl = URL(string: headerData?.urlToImage ?? "https://discountseries.com/wp-content/uploads/2017/09/default.jpg")
                self.headerNews?.headerImage.sd_setImage(with: headerImageUrl, completed: nil)
                self.tableView.reloadData()
            }
        }
    }
    
}

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let articleURL = URL(string: viewModel.items[indexPath.row].url ?? "" ) else { return }
        let vc = ResultNewsController()
        vc.webView.load(URLRequest(url: articleURL))
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as? HomeTableViewCell else { fatalError() }
        let article = viewModel.items[indexPath.row]
        let imageURL = URL(string: article.urlToImage ?? "https://discountseries.com/wp-content/uploads/2017/09/default.jpg")
        cell.newsTitleLabel.text = article.title ?? ""
        cell.describtionLabel.text = article.description ?? ""
        cell.newsImage.layer.cornerRadius = 7
        cell.newsImage.sd_setImage(with: imageURL, completed: nil)
        return cell
    }
}
