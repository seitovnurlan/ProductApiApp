//
//  AuthorizationViewController.swift
//  ProductApiApp
//
//  Created by Nurlan Seitov on 6/6/23.
//

import UIKit

class AuthorizationViewController: UIViewController {

    private let image: UIImageView = {
        let mainImage = UIImageView()
        mainImage.image = UIImage(named: "image")
        return mainImage
    }()
    
    private let welcomLabel: UILabel  = {
        let welcomeLbl = UILabel()
        welcomeLbl.text = "Welcome"
        welcomeLbl.textColor = .white
        welcomeLbl.font = .boldSystemFont(ofSize: 28)
        return welcomeLbl
    }()
    
    private let infoLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Login to your account"
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 20)
        return lbl
    }()
    
    private let loginLabel: UILabel = {
        let loginLbl = UILabel()
        loginLbl.text = "Phone number"
        loginLbl.font = .systemFont(ofSize: 18)
        loginLbl.textColor = .white
        return loginLbl
    }()
    
    private var loginTextField: UITextField = {
        var loginTF = UITextField()
        loginTF.placeholder = "Login"
        loginTF.layer.cornerRadius = 6
        loginTF.backgroundColor = .white
        loginTF.layer.borderWidth = 1
        return loginTF
    }()
    
    private let passwordLabel: UILabel = {
        let passwordLbl = UILabel()
        passwordLbl.text = "Password"
        passwordLbl.font = .systemFont(ofSize: 18)
        passwordLbl.textColor = .white
        return passwordLbl
    }()
    
    private let passwordTextField: UITextField = {
        let passwordTF = UITextField()
        passwordTF.placeholder = "Password"
        passwordTF.backgroundColor = . white
        passwordTF.layer.cornerRadius = 6
        passwordTF.layer.borderWidth = 1
        passwordTF.isSecureTextEntry = false
        return passwordTF
    }()
    
    private let eyeButton: UIButton = {
        let eyeBtn = UIButton()
        eyeBtn.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        return eyeBtn
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Not Saved", for: .normal)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 12
        button.tintColor = .white
        return button
    }()
    
    private let loginButton: UIButton = {
        let loginBtn = UIButton()
        loginBtn.setTitle("Login", for: .normal)
        loginBtn.layer.backgroundColor = UIColor.tintColor.cgColor
        loginBtn.layer.cornerRadius = 18
        return loginBtn
    }()
    
    private let createNowButton: UIButton = {
        let createNowBtn = UIButton()
        createNowBtn.setTitle("Create Now", for: .normal)
        createNowBtn.tintColor = .white
        return createNowBtn
    }()
    
    private let accountLabel: UILabel = {
        let accountLbl = UILabel()
        accountLbl.text = "Don't have account?"
        accountLbl.textColor = .gray
        accountLbl.font = .systemFont(ofSize: 16)
        return accountLbl
    }()
    
    private let googleImageView: UIImageView = {
        let google = UIImageView()
        google.image = UIImage(named: "google")
        return google
    }()
    
    private let facebookImageView: UIImageView = {
        let facebook = UIImageView()
        facebook.image = UIImage(named: "facebook")
        return facebook
    }()
    
    private let instagramImageView: UIImageView = {
        let instagram = UIImageView()
        instagram.image = UIImage(named: "instagram")
        return instagram
    }()
    
    private var isSave = false {
        didSet {
            let isSavedTitle = isSave ? "Saved" : "Save"
            saveButton.setTitle(isSavedTitle, for: .normal)
        }
    }
    
    private let viewModel = AuthorizationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initAction()
        handleLoginField()
    }
    
    private func handleLoginField() {
        
    }
    
    func initUI() {
        view.addSubview(welcomLabel)
        view.addSubview(infoLabel)
        view.addSubview(image)
        view.addSubview(loginLabel)
        view.addSubview(loginTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(saveButton)
        view.addSubview(loginButton)
        view.addSubview(createNowButton)
        view.addSubview(accountLabel)
        view.addSubview(googleImageView)
        view.addSubview(facebookImageView)
        view.addSubview(instagramImageView)
        view.addSubview(eyeButton)
        
        
        image.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.leading.trailing.equalToSuperview().inset(0)
            make.height.equalTo(200)
        }
        
        welcomLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(280)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.centerX.equalTo(welcomLabel)
            make.top.equalTo(welcomLabel.snp.bottom).offset(4)
        }
        
        loginLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.top.equalTo(infoLabel.snp.bottom).offset(28)
        }
        
        loginTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(28)
            make.top.equalTo(loginLabel.snp.bottom).offset(8)
            make.height.equalTo(48)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(28)
            make.top.equalTo(loginTextField.snp.bottom).offset(8)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(28)
            make.top.equalTo(passwordLabel.snp.bottom).offset(8)
            make.height.equalTo(48)
        }
        
        eyeButton.snp.makeConstraints { make in
            make.trailing.equalTo(passwordTextField.snp.trailing).offset(-4)
            make.centerY.equalTo(passwordTextField)
            make.width.equalTo(28)
            make.height.equalTo(24)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(4)
            make.trailing.equalTo(passwordTextField.snp.trailing)
        }
        
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-200)
            make.height.equalTo(48)
            make.width.equalTo(280)
        }
        
        createNowButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(4)
            make.trailing.equalTo(loginButton.snp.trailing)
        }
        
        accountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(createNowButton)
            make.trailing.equalTo(createNowButton.snp.leading).offset(-4)
        }
        
        facebookImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-80)
        }
        
        instagramImageView.snp.makeConstraints { make in
            make.leading.equalTo(facebookImageView).offset(60)
            make.bottom.equalToSuperview().offset(-80)
        }
        
        googleImageView.snp.makeConstraints { make in
            make.trailing.equalTo(facebookImageView).offset(-60)
            make.bottom.equalToSuperview().offset(-80)
        }
    }
    
    private func initAction() {
        createNowButton.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(authorizeTap), for: .touchUpInside)
        eyeButton.addTarget(self, action: #selector(tapEyeButton), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveLoginTap), for: .touchUpInside)
    }
    
    @objc
    private func tapAction(sender: UIButton!) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: TabViewController.self))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    private func authorizeTap(sender: UIButton) {
        guard let smsCode = passwordTextField.text else {
            return
        }
        viewModel.tryToSignIn(smsCode: smsCode) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success:
                // NOTE: - Push next view controller
                print("Suucess signIn")
                let vc = UIStoryboard(
                    name: "Main",
                    bundle: nil
                ).instantiateViewController(
                    withIdentifier: String(describing: AuthorizationViewController.self)
                )
                vc.modalPresentationStyle = .fullScreen
                self.present(
                    vc,
                    animated: false
                )
            case .failure:
                // NOTE: - Show alert
                print("Failed signIn")
                break
            }
        }
    }
    
    @objc
    private func tapEyeButton(sender: UIButton) {
        passwordTextField.isSecureTextEntry = true
    }
    
    @objc
    private func saveLoginTap(sender: UIButton) {
        guard let phoneNumber = loginTextField.text else {
            return
        }
        viewModel.tryToSendSMSCode(phoneNumber: phoneNumber) { result in
            switch result {
            case .success:
                // NOTE: - Push next view controller
                print("Success smscode")
                break
            case .failure:
                // NOTE: - Show alert
                print("Failed smscode")
                break
            }
        }
    }
}
