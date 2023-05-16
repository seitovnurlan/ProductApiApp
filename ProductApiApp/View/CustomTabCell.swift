//
//  CustomTabCell.swift
//  ProductApiApp
//
//  Created by Nurlan Seitov on 16/5/23.
//

import UIKit

class CustomTabCell: UITableViewCell {

    @IBOutlet weak var imageCustTab: UIImageView!
    
    @IBOutlet weak var brandLabel: UILabel!
    
    @IBOutlet weak var openLabel: UILabel!
    
    @IBOutlet weak var raitLabel: UILabel!
    
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var productLabel: UILabel!
    
    @IBOutlet weak var deliveryLabel: UILabel!
    
    @IBOutlet weak var rentLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    
    static let reuseId = String(describing: CustomTabCell.self)
    static let nibName = String(describing: CustomTabCell.self)
    
    public func initUI(image: String, brand: String, open: String, rait: String, country: String, time: String,
                       product: String, delivery: String, rent: String, distance: String) {
        imageCustTab.image = UIImage(named: image)
        brandLabel.text = brand
        openLabel.text = open
        raitLabel.text = rait
        countryLabel.text = country
        timeLabel.text = time
        productLabel.text = product
        deliveryLabel.text = delivery
        rentLabel.text = rent
        distanceLabel.text = distance
    }
    override func layoutSubviews() {
        
    }
    
}
