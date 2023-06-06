//
//  ViewController.swift
//  ProductApiApp
//
//  Created by Nurlan Seitov on 8/5/23.
//

import UIKit
import SnapKit
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet private weak var deliveryCollectionView: UICollectionView!
    @IBOutlet private weak var categoryCollectionView: UICollectionView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var searchBarVC: UISearchBar!
    
    private var isFiltered = false
    private var filteredProducts: [Product] = [] {
        didSet {
//            print("Items count: \(filteredProducts.count)")
            countLabel.text = String(isFiltered ? filteredProducts.count : products.count)
        }
    }
    private var products: [Product] = [] {
        didSet {
            countLabel.text = String(isFiltered ? filteredProducts.count : products.count)
//            let categoryTitles = Array(Set(products.map {$0.category ?? "Empty category" }))
//            categoryTitles.forEach { item in
//                categories.map { Category(title: item, image: $0.image)}
//            }
//            categoryCollectionView.reloadData()
         }
    }
    
     let deliveries = [
        Delivery(title: "Delivery", image: "scooter2"),
        Delivery(title: "Pickup", image: "pickup"),
        Delivery(title: "Catering", image: "catering"),
        Delivery(title: "Curbside", image: "curbside2")
    ]
    
    private let categories = [
        Category(title: "Takeaways", image: "takeaways"),
        Category(title: "Grocery", image: "groceries"),
        Category(title: "Convenience", image: "convenience"),
        Category(title: "Pharmacy", image: "pharmacy"),
        Category(title: "Skincare", image: "skincare"),
        Category(title: "Home-decoration", image: "home-decoration"),
        Category(title: "Fragrances", image: "fragrances"),
        Category(title: "Smartphones", image: "smartphones"),
        Category(title: "Laptops", image: "laptops"),
    ]
    
    private let viewModel = HomeViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchProducts()
        categoryCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray5
        setupCollViewCategor()
        setupCollViewType()
        setuptableView()
        
        print("Product title is: \(String(describing: UserdefaultStorage.shared.getString(forKey: .titleName)))")
        
        let data: Any? = KeyChainStorage.shared.read(
            with: Constants.Keychain.service,
            Constants.Keychain.account
        )
              print("model is: \(data!)")
        
//        let data = KeyChainStorage.shared.read(
//            with: Constants.Keychain.service,
//            Constants.Keychain.account
//        )
//        if let data {
//            print("Model is: \(String(data: data, encoding: .utf8))")
//        }
    }
    
    private func setupCollViewCategor() {
        deliveryCollectionView.dataSource = self
        deliveryCollectionView.delegate = self
        deliveryCollectionView.register(
            UINib(nibName: CategoriaCVCell.nibName, bundle: nil),
            forCellWithReuseIdentifier: CategoriaCVCell.reuseId
        )
        deliveryCollectionView.backgroundColor = .systemGray5
    }
    private func setupCollViewType() {
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.register(
            UINib(nibName: TypeCVCell.nibName, bundle: nil),
            forCellWithReuseIdentifier: TypeCVCell.reuseId
        )
        categoryCollectionView.backgroundColor = .systemGray5
    }
    
    private func setuptableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(
            nibName: CustomTabCell.nibName,
            bundle: nil),
            forCellReuseIdentifier: CustomTabCell.reuseId
        )
        
        tableView.backgroundColor = .white
    }
    
    private func fetchProducts() {

        Task {
            do {
                let response = try await viewModel.fetchProducts()
                DispatchQueue.main.async {
                    self.products = response.products
                    self.tableView.reloadData()
                }
            } catch {
                showAlert(with: error.localizedDescription)
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return collectionView == categoryCollectionView
        ? categories.count
        : deliveries.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        collectionView == deliveryCollectionView
        ? getDeliveryCell(for: indexPath)
        : getCategoryCell(for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView == deliveryCollectionView {
//            print("deliveryCollectionView \(indexPath.item)")
//        }
        if collectionView == categoryCollectionView {
            // MARK: -  filter products
            isFiltered.toggle()
            let category = categories[indexPath.row]
            filteredProducts = products.filter {
                $0.category!.lowercased().contains(
                    category.title.lowercased()
                )
            }
            tableView.reloadData()
        }
        
    }
    private func getDeliveryCell(for indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = deliveryCollectionView.dequeueReusableCell(
            withReuseIdentifier: CategoriaCVCell.reuseId,
            for: indexPath
        ) as? CategoriaCVCell else {
            return UICollectionViewCell()
        }
        
        let delivery = deliveries[indexPath.row]
        cell.display(item: delivery)
        return cell
    }
    
    private func getCategoryCell(for indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = categoryCollectionView.dequeueReusableCell(
            withReuseIdentifier: TypeCVCell.reuseId,
            for: indexPath
        ) as? TypeCVCell else {
            return UICollectionViewCell()
        }
        let category = categories[indexPath.row]
        cell.display(item: category)
        return cell
    }
    
}
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
       return isFiltered ? filteredProducts.count : products.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CustomTabCell.reuseId,
            for: indexPath
        ) as? CustomTabCell else {
            return UITableViewCell()
        }
        let product: Product
        if !isFiltered {
            product = products[indexPath.row]
        } else {
            product = filteredProducts[indexPath.row]
        }
        cell.display(item: product)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = products[indexPath.row]
        UserdefaultStorage.shared.save(
            model.title,
            forKey: .titleName
        )
//        let data = try! JSONEncoder().encode(model)
        KeyChainStorage.shared.save(
//            data,
            model,
            service: Constants.Keychain.service,
            account: Constants.Keychain.account
        )
    }
}

//let json = """
//[{
//"title": "Grocery"
//},
//{
//"title": "Grocery"
//},
//{
//"title": "Grocery"
//},
//{
//"title": "Grocery"
//},
//{
//"title": "Grocery"
//}]
//"""
