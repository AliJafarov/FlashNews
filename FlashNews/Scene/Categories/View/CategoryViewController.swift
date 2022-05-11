//
//  CategoryViewController.swift
//  FlashNews
//
//  Created by Ali Jafarov on 05.05.22.
//

import UIKit

class CategoryViewController: UIViewController {
    
    
    let categoriesVM = CategoriesViewModel()
        
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        getdata()
    }
    
    func getdata() {
        categoriesVM.getDefaultCategoryData {
            self.tableView.reloadData()
        }
    }
    
    
    private func downloadNews(indexPath: IndexPath) {
        
        let data = categoriesVM.selectedCategoryArray.isEmpty ? categoriesVM.defaultNewsArray[indexPath.row] : categoriesVM.selectedCategoryArray[indexPath.row]
        
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

//MARK: - CollectionView extensions

extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesVM.categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        cell.isUserInteractionEnabled = true
        cell.layer.cornerRadius = 7
        cell.categoryLabels.text = categoriesVM.categoryArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        DispatchQueue.main.async {
            self.categoriesVM.getSelectedCategoryData(self.categoriesVM.categoryArray[indexPath.item]) {
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size: CGSize = categoriesVM.categoryArray[indexPath.row].size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0)])
            return CGSize(width: size.width + 45.0, height: 30)
        }
}

//MARK: - Tableview extensions

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource, TableViewCellDelegate {
    
    func didtaped(indexPath: IndexPath) {
    //////////
        let vc = ResultNewsController()
        vc.url = categoriesVM.selectedCategoryArray.isEmpty ? categoriesVM.defaultNewsArray[indexPath.row].url ?? "" : categoriesVM.selectedCategoryArray[indexPath.row].url ?? ""
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return categoriesVM.selectedCategoryArray.isEmpty ? categoriesVM.defaultNewsArray.count : categoriesVM.selectedCategoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? CategoriesTableViewCell else { return UITableViewCell() }
        let data = categoriesVM.selectedCategoryArray.isEmpty ? categoriesVM.defaultNewsArray[indexPath.row] : categoriesVM.selectedCategoryArray[indexPath.row]
        cell.configure(data: data)
        cell.delegate = self
        cell.indexPath = indexPath
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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



