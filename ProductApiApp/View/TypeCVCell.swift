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
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
   
    public func initUI(image: String, title: String) {
        imageView.image = UIImage(named: image)
        titleLabel.text = title
    }
    override func layoutSubviews() {
        
    }
}
