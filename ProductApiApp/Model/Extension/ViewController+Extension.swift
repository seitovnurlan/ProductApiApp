//
//  ViewController+Extension.swift
//  ProductApiApp
//
//  Created by Nurlan Seitov on 31/5/23.
//

import UIKit

extension UIViewController {
    func showAlert(with title: String, message: String? =  nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .cancel))
        self.present(alert, animated: true)
    }
}
