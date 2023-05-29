//
//  SearchBarViewController.swift
//  ProductApiApp
//
//  Created by Nurlan Seitov on 17/5/23.
//

import UIKit

class SearchBarViewController: UIViewController {
    
    private let networkLayer = NetworkLayer()
    private var dataProduct: [Product] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableViewSearch: UITableView!
    
    private var filteredProduct: [Product] = []
    
    private var isFiltered: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConfig()
        
    }
    
    // MARK: - Methods
    
    private func setupConfig() {
        searchBar.placeholder = "Поиск"
        tableViewSearch.dataSource = self
        tableViewSearch.delegate = self
        searchBar.delegate = self
        tableViewSearch.register(UINib(nibName: CustomTabCell.nibName, bundle: nil), forCellReuseIdentifier: CustomTabCell.reuseId)
        loadApiawait()
//        loadApi()
    }
//    private func loadApi() {
//
//        let networkLayer = NetworkLayer()
//        networkLayer.requestDataModel { [weak self] result in
//            switch result {
//            case .success(let data):
//                DispatchQueue.main.async {
//                    guard let `self` else {return}
//                    self.dataProduct = data.products ?? []
//                    self.tableViewSearch.reloadData()
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    private func loadApiawait() {

        Task {
            do {
                let response = try await networkLayer.requestDataModel()
                DispatchQueue.main.async {
                    self.dataProduct = response.products
                    self.tableViewSearch.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
extension SearchBarViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        isFiltered ? filteredProduct.count : dataProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTabCell.reuseId, for: indexPath)
                as? CustomTabCell
        else { return UITableViewCell() }
        
        cell.initUI(
            image: dataProduct[indexPath.row].thumbnail ?? "",
            brand: dataProduct[indexPath.row].title ?? "",
            open: "OPEN",
            rait: String(dataProduct[indexPath.row].rating ?? 0.0),
            country: dataProduct[indexPath.row].brand ?? "",
            time: "15-20 min",
            product: dataProduct[indexPath.row].category ?? "",
            delivery: "Delivery: FREE",
            rent: String(dataProduct[indexPath.row].price ?? 0),
            distance: "1.5 km away")
        
        cell.imageCustTab.layer.cornerRadius = 5
        cell.imageCustTab.layer.borderWidth = 2
        cell.imageCustTab.layer.borderColor = UIColor.gray.cgColor
        
        if isFiltered  {
            cell.productLabel?.text = filteredProduct[indexPath.row].category
            cell.imageCustTab?.image = UIImage(named: filteredProduct[indexPath.row].thumbnail ?? "")
            cell.layer.cornerRadius = 10
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.red.cgColor
            
         }
         else
         {
             cell.productLabel?.text = dataProduct[indexPath.row].category
             cell.imageCustTab?.image = UIImage(named: dataProduct[indexPath.row].thumbnail ?? "")
             cell.layer.cornerRadius = 10
             cell.layer.borderWidth = 1
             cell.layer.borderColor = UIColor.white.cgColor
         }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        320
    }
}

extension SearchBarViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            isFiltered = false
        } else {
            isFiltered = true
            
            // filteredStudents = students.filter { $0.contains(searchText)
          //  filteredUsers = users.filter { $0.lowercased().contains(searchText.lowercased())
            filteredProduct = dataProduct.filter { $0.category!.lowercased().contains(searchText.lowercased()) }
          //  filteredUsers = users.filter { $0.imageOne }
            
        }
           tableViewSearch.reloadData()
    }
}
