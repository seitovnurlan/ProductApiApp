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
    
    var data: [Product] = []
    
    private let categoriesImage = [
        UIImage(named: "scooter2")!,
        UIImage(named: "pickup")!,
        UIImage(named: "catering")!,
        UIImage(named: "curbside2")!,
    ]
    private let typeOfImages = [
        UIImage(named: "Takeaways")!,
        UIImage(named: "Grocery")!,
        UIImage(named: "Convenience")!,
        UIImage(named: "Pharmacy")!,
    ]
    private let titleCategoriArray = ["Delivery", "Pickup", "Catering", "Curbside"]
    private let titleTypeOfDeliveryArray = ["Takeaways", "Grocery", "Convenience", "Pharmacy"]
    
    @IBOutlet weak var collectionViewCateg: UICollectionView!
    
    @IBOutlet weak var collectionViewType: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    
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
        tableView.register(UINib(nibName: CustomTabCell.nibName, bundle: nil), forCellReuseIdentifier: CustomTabCell.reuseId)
        
//        tableView.backgroundColor = .systemGray5
        tableView.backgroundColor = .white
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
                    self.tableView.reloadData()
//                    let vc = GetRequestPage()
//                    vc.data = data.products ?? []
//                     self.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == collectionViewType {
            return titleTypeOfDeliveryArray.count
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
            //        cell.layer.borderWidth = 2
            //        cell.layer.borderColor = UIColor.red.cgColor
//            cell.backgroundColor = .white
            cell.imageView.image = typeOfImages[indexPath.row]
            //        cell.imageView.tintColor = .red
            //        cell.imageView.image?.withTintColor(.blue)
            //        cell.imageView.layer.backgroundColor = UIColor.green.cgColor
            cell.titleLabel.text = titleTypeOfDeliveryArray[indexPath.row]
            cell.titleLabel.textColor = UIColor(named: "textColor")
            
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
        }
    }
}
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTabCell") as? CustomTabCell
//        let value = data[indexPath.row]
//        cell?.imageCustTab.image = UIImage(named: data[indexPath.row].thumbnail ?? "")
//        cell?.imageCustTab.image = UIImage(named: data[indexPath.row].thumbnail ?? "")
        
        cell?.brandLabel.text = data[indexPath.row].title
        cell?.productLabel.text = data[indexPath.row].description
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
}
