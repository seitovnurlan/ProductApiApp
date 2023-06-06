//
//  SearchBarViewController.swift
//  ProductApiApp
//
//  Created by Nurlan Seitov on 17/5/23.
//

import UIKit

class SearchBarViewController: UIViewController {
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableViewSearch: UITableView!
    
    private let viewModel = SearchBarViewModel()
    private var products: [Product] = []
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
        tableViewSearch.register(
            UINib(
                nibName: CustomTabCell.nibName,
                bundle: nil),
                forCellReuseIdentifier: CustomTabCell.reuseId
        )
        loadApiawait()
    }
    
    private func loadApiawait() {
        Task {
            do {
                let response = try await viewModel.fetchProducts()
                DispatchQueue.main.async {
                    self.products = response.products
                    self.tableViewSearch.reloadData()
                }
            } catch {
                showAlert(with: error.localizedDescription)
            }
        }
    }
}
extension SearchBarViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        isFiltered ? filteredProduct.count : products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CustomTabCell.reuseId,
            for: indexPath
        ) as? CustomTabCell else {
            return UITableViewCell()
        }
        let product = products[indexPath.row]
        cell.display(item: product)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        320
    }
}

extension SearchBarViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isFiltered = !searchText.isEmpty
        if isFiltered {
            filteredProduct = products.filter {
                $0.category!.lowercased().contains(
                    searchText.lowercased()
                )
            }
            tableViewSearch.reloadData()
        }
    }
}
