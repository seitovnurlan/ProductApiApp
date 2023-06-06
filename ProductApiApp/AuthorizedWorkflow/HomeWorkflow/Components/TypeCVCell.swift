//
//  TypeCVCell.swift
//  ProductApiApp
//
//  Created by Nurlan Seitov on 8/5/23.
//

import UIKit

class TypeCVCell: UICollectionViewCell {

    static let reuseId = String(describing: TypeCVCell.self)
    static let nibName = String(describing: TypeCVCell.self)
    
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
   
    public func initUI(image: String, title: String) {
        imageView.image = UIImage(named: image)
        titleLabel.text = title
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
    }
    func display(item: Category) {
        imageView.image = UIImage(named: item.image)
        titleLabel.text = item.title
        titleLabel.textColor = UIColor(named: "textColor")
    }
}
