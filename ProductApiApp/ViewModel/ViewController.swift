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
    
    private let networkLayer = NetworkLayer()
    var dataCategory: [DataModel] = []
    var data: [Product] = [] {
        didSet {
            
            categories = Array(Set(data.map { $0.category ?? "Empty category" }))
            collectionViewType.reloadData()
        }
    }
    
    private let categoriesImage = [
        UIImage(named: "scooter2")!,
        UIImage(named: "pickup")!,
        UIImage(named: "catering")!,
        UIImage(named: "curbside2")!,
    ]
    private let typeOfImages = [
        "takeaways",
        "grocery",
        "convenience",
        "pharmacy",
        "laptops2",
        "skincare2",
        "home-decoration2",
        "fragrances2",
        "smartphones2"
    ]
    private let titleCategoriArray = ["Delivery", "Pickup", "Catering", "Curbside"]
//    private let titleTypeOfDeliveryArray = ["Takeaways", "Grocery", "Convenience", "Pharmacy"]
    
    private let categoriesStruct = [
        Category(title: "Takeaways", image: "takeaways"),
        Category(title: "Grocery", image: "grocery"),
        Category(title: "Convenience", image: "convenience"),
        Category(title: "Pharmacy", image: "pharmacy"),
        Category(title: "Skincare", image: "skincare"),
        Category(title: "Home-decoration", image: "home-decoration"),
        Category(title: "Fragrances", image: "fragrances"),
        Category(title: "Smartphones", image: "smartphones"),
        Category(title: "Laptops", image: "laptops"),
    ]
    
    
    private var categories: [String] = []
    
    @IBOutlet weak var collectionViewCateg: UICollectionView!
    
    @IBOutlet weak var collectionViewType: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var countLabel: UILabel!
    
    
    @IBOutlet weak var searchBarVC: UISearchBar!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadApiawait()
        collectionViewType.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray5
        setupCollViewCategor()
        setupCollViewType()
        setuptableView()
    }
    
    private func setupCollViewCategor() {
        collectionViewCateg.dataSource = self
        collectionViewCateg.delegate = self
        collectionViewCateg.register(
            UINib(nibName: CategoriaCVCell.nibName, bundle: nil),
            forCellWithReuseIdentifier: CategoriaCVCell.reuseId
        )
        collectionViewCateg.backgroundColor = .systemGray5
    }
    private func setupCollViewType() {
        collectionViewType.dataSource = self
        collectionViewType.delegate = self
        collectionViewType.register(
            UINib(nibName: TypeCVCell.nibName, bundle: nil),
            forCellWithReuseIdentifier: TypeCVCell.reuseId
        )
        collectionViewType.backgroundColor = .systemGray5
    }
    
    private func setuptableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(
            nibName: CustomTabCell.nibName,
            bundle: nil),
            forCellReuseIdentifier: CustomTabCell.reuseId
        )
        
//        tableView.backgroundColor = .systemGray5
        tableView.backgroundColor = .white
       // loadApiawait()
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
//                    self.data = data.products ?? []
//                    self.tableView.reloadData()
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
        
                    self.data = response.products
                    self.tableView.reloadData()
                }
            } catch {
//                print(error.localizedDescription)
                showAlert(with: error.localizedDescription)
            }
        }
    }
    
    private func loadApiCategory(category: String) {

        Task {
            do {
                let response = try await networkLayer.requestDataModel()
                DispatchQueue.main.async {
        
                    self.data = response.products.filter({
                        $0.category == category
                    })
                    self.tableView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        
        if collectionView == collectionViewType {
            return categories.count
        } else {
            return titleCategoriArray.count
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionViewCateg {
            
            guard let cell = collectionViewCateg.dequeueReusableCell(withReuseIdentifier: CategoriaCVCell.reuseId, for: indexPath) as? CategoriaCVCell else {
                return UICollectionViewCell()
            }
            cell.layer.cornerRadius = 18
            //        cell.layer.borderWidth = 2
            //        cell.layer.borderColor = UIColor.red.cgColor
        
//            cell.backgroundColor = UIColor(red: 0.2, green: 0.4, blue: 0.6, alpha: 1)
          cell.backgroundColor = UIColor(named: "selectColor")
            cell.imageView.image = categoriesImage[indexPath.row].withTintColor(.white)
//            cell.imageView.tintColor = UIColor.white
            //        cell.imageView.image?.withTintColor(.blue)
            //        cell.imageView.layer.backgroundColor = UIColor.green.cgColor
            cell.titleLabel.text = titleCategoriArray[indexPath.row]
            cell.titleLabel.textColor = .white
            
            return cell
        } else {
            guard let cell = collectionViewType.dequeueReusableCell(withReuseIdentifier: TypeCVCell.reuseId,
                for: indexPath) as? TypeCVCell else {
                return UICollectionViewCell()
            }
            cell.layer.cornerRadius = 10
//            cell.layer.borderWidth = 2
//            cell.layer.borderColor = UIColor.red.cgColor
//            cell.backgroundColor = .white
            
                
//                cell.imageView.tintColor = .red
//                cell.imageView.image?.withTintColor(.blue)
//                cell.imageView.layer.backgroundColor = UIColor.white.cgColor
            
                cell.titleLabel.text = categories[indexPath.row]
                cell.titleLabel.textColor = UIColor(named: "textColor")
                cell.imageView.image = UIImage(named:"\(categories[indexPath.row])")
        
                return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView == collectionViewCateg {
//            self.collectionViewCateg.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//        }
        if collectionView == collectionViewCateg {
            print("collectionViewCateg \(indexPath.item)")
        }
        if collectionView == collectionViewType {
            
            print("collectionViewType \(indexPath.item)")
//            print(categories)
            loadApiCategory(category: categories[indexPath.row])
            
        }
        
    }
}
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countLabel.text = String(data.count)
       return data.count
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
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
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
