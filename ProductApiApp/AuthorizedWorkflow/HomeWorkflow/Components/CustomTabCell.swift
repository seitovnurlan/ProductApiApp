//
//  CustomTabCell.swift
//  ProductApiApp
//
//  Created by Nurlan Seitov on 16/5/23.
//

import UIKit
import Kingfisher

class CustomTabCell: UITableViewCell {

    @IBOutlet private weak var imageCustTab: UIImageView!
    @IBOutlet private weak var brandLabel: UILabel!
    @IBOutlet private weak var openLabel: UILabel!
    @IBOutlet private weak var raitLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var productLabel: UILabel!
    @IBOutlet private weak var deliveryLabel: UILabel!
    @IBOutlet private weak var rentLabel: UILabel!
    @IBOutlet private weak var distanceLabel: UILabel!
    
    static let reuseId = String(describing: CustomTabCell.self)
    static let nibName = String(describing: CustomTabCell.self)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageCustTab.layer.cornerRadius = 5
        imageCustTab.layer.borderWidth = 2
        imageCustTab.layer.borderColor = UIColor.gray.cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageCustTab.image = nil
    }
    func display(item: Product) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard
                let thumbnail = item.thumbnail,
                let url = URL(string: thumbnail),
                let data = try? Data(contentsOf: url)
            else {
                return
            }
            DispatchQueue.main.async {
                self.imageCustTab.image = UIImage(data: data)
            }
        }
        brandLabel.text = item.title
        openLabel.text = "OPEN"
        raitLabel.text = String(item.rating ?? .zero)
        countryLabel.text = item.brand
        timeLabel.text = "15-20 min"
        productLabel.text = item.category
        deliveryLabel.text = "Delivery: FREE"
        rentLabel.text = String(item.price ?? .zero)
        distanceLabel.text = "1.5 km away"
    }
}
