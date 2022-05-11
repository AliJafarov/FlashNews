//
//  HomeController.swift
//  FlashNews
//
//  Created by Shamkhal Guliyev on 26.04.22.
//

import UIKit
import DropDown

class HomeController: UIViewController {
    

    
    @IBOutlet  var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
        
    let viewModel = HomeViewModel()
    private var headerNews: NewsHeader?
        
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.hidesBottomBarWhenPushed = true
        self.tableView.keyboardDismissMode = .onDrag
        searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        let leftNavBarButton = UIBarButtonItem(customView: searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        
        headerNews = NewsHeader(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 270))
        tableView.tableHeaderView = headerNews
        headerNews!.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(goToWebView))
        headerNews?.addGestureRecognizer(gestureRecognizer)
        getData()
        hideKeyboard()
    }
    
    
    
    @objc func goToWebView() {
        let vc = ResultNewsController()
        vc.url = headerNews?.url ?? ""
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func getData() {
        viewModel.getHomeData() {
            self.headerNews?.configure(data: self.viewModel.items.randomElement())
            self.tableView.reloadData()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.searchBar.endEditing(true)
//            self.tabBarController?.tabBar.isHidden = false
        }
    }
    
    @IBAction func selectCountry(_ sender: Any) {
        let dropdown = DropDown()
        dropdown.anchorView = tableView
        dropdown.dataSource = Array(viewModel.countries.keys)
        dropdown.show()
        dropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.viewModel.getCountryData(Array(viewModel.countries.values)[index]) {
                self.headerNews?.configure(data: self.viewModel.countryItems.randomElement())
                self.tableView.reloadData()
                let indexPath = IndexPath(row: NSNotFound, section: 0)
                   self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
    
    private func downloadNews(indexPath: IndexPath) {
        
        let data = viewModel.countryItems.isEmpty ? viewModel.items[indexPath.row] : viewModel.countryItems[indexPath.row]
        
        DataPersistanceManager.shared.downloadArticle(model: data) { result in
              switch result{
              case .success():
                  print("Data downloaded to database")
              case .failure(let error):
                  print(error.localizedDescription)
              }
              
          }
      }
    
}


//MARK: - TableView

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ResultNewsController()
        vc.url = viewModel.countryItems.isEmpty ? viewModel.items[indexPath.row].url ?? "" : viewModel.countryItems[indexPath.row].url ?? ""
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
        hideKeyboard()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countryItems.isEmpty ? viewModel.items.count : viewModel.countryItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as? HomeTableViewCell else { fatalError() }
            let data = viewModel.countryItems.isEmpty ? viewModel.items[indexPath.row] : viewModel.countryItems[indexPath.row]
            cell.configure(data: data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) {[weak self] _ in
                let downloadAction = UIAction(title: "Download", subtitle: nil, image: UIImage(systemName: "square.and.arrow.down"), identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                        self?.downloadNews(indexPath: indexPath)
                          }
                          return UIMenu(title: "", image: nil, identifier: nil , options: .displayInline, children: [downloadAction])
               }
               return configuration
        
    }

}


//MARK: - SearchBar

extension HomeController: UISearchBarDelegate {
    
    func hideKeyboard() {
        // To hide the keyboard
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(tableView.endEditing))
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
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let searchText = (searchBar.text ?? "") + text
        
        if searchText.count > 3 {
            //TODO: call search api
            print("i am here")
        }
        
        return true
    }
}

