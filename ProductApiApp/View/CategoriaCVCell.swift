//
//  CategoriaCVCell.swift
//  ProductApiApp
//
//  Created by Nurlan Seitov on 8/5/23.
//

import UIKit

class CategoriaCVCell: UICollectionViewCell {
    
    static let reuseId = String(describing: CategoriaCVCell.self)
    static let nibName = String(describing: CategoriaCVCell.self)

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    public func initUI(image: String, title: String) {
        imageView.image = UIImage(named: image)
        titleLabel.text = title
    }
    override func layoutSubviews() {
        
    }
}
