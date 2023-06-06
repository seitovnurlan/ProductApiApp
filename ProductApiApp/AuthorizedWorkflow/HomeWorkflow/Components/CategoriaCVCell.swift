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

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 18
        backgroundColor = UIColor(named: "selectColor")
    }
    
    func display(item: Delivery) {
        imageView.image = UIImage(named: item.image)?.withTintColor(.white)
        titleLabel.text = item.title
        titleLabel.textColor = .white
    }
}
