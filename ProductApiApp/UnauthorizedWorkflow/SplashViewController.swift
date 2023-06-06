//
//  SplashViewController.swift
//  ProductApiApp
//
//  Created by Nurlan Seitov on 6/6/23.
//

import UIKit

class SplashViewController: UIViewController {

    private let keychain = KeyChainStorage.shared
    private let encoder = JSONDecoder()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        if
            let data = keychain.read(
                with: Constants.Keychain.service,
                Constants.Keychain.account
            ),
            let date = try? decoder.decode(Date.self, from: data),
//            let date = try? model
            date > Date() {
            handleAuthorizedFlow()
        } else {
            handleNotAuthorizedFlow()
        }
    }
    
    deinit {
        print("SplashViewController deinit")
    }
    
    private func handleNotAuthorizedFlow() {
        let vc = UIStoryboard(
            name: "Main",
            bundle: nil
        ).instantiateViewController(
            withIdentifier: String(describing: AuthorizationViewController.self)
        )
        vc.modalPresentationStyle = .fullScreen
        present(
            vc,
            animated: false
        )
    }
    
    private func handleAuthorizedFlow() {
        let vc = UIStoryboard(
            name: "Main",
            bundle: nil
        ).instantiateViewController(
            withIdentifier: String(describing: TabViewController.self)
        )
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: false)
        present(
            vc,
            animated: false
        )
    }
}
