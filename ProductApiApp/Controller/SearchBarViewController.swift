//
//  SearchBarViewController.swift
//  ProductApiApp
//
//  Created by Nurlan Seitov on 17/5/23.
//

import UIKit

class SearchBarViewController: UIViewController {

    var data: [Product] = []
    
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
        loadApi()
    }
    private func loadApi() {
        
        let networkLayer = NetworkLayer()
        networkLayer.requestDataModel { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    guard let `self` else {return}
                    self.data = data.products ?? []
                    self.tableViewSearch.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
extension SearchBarViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        isFiltered ? filteredProduct.count : data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTabCell.reuseId, for: indexPath)
                as? CustomTabCell
        else { return UITableViewCell() }
        
        cell.initUI(
            image: data[indexPath.row].thumbnail ?? "",
            brand: data[indexPath.row].title ?? "",
            open: "OPEN",
            rait: String(data[indexPath.row].rating ?? 0.0),
            country: data[indexPath.row].brand ?? "",
            time: "15-20 min",
            product: data[indexPath.row].category ?? "",
            delivery: "Delivery: FREE",
            rent: String(data[indexPath.row].price ?? 0),
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
             cell.productLabel?.text = data[indexPath.row].category
             cell.imageCustTab?.image = UIImage(named: data[indexPath.row].thumbnail ?? "")
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
            filteredProduct = data.filter { $0.category!.lowercased().contains(searchText.lowercased()) }
          //  filteredUsers = users.filter { $0.imageOne }
            
        }
           tableViewSearch.reloadData()
    }
}
