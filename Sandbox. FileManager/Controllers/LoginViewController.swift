//
//  LoginViewController.swift
//  Sandbox. FileManager
//
//  Created by Oleg Popov on 13.12.2022.
//

import Foundation
import UIKit
import KeychainAccess

class LoginViewController: UIViewController {
    
    let keychain = Keychain(service: "FileManager")
    var entryPassword = ""
    var firstEntryPassword = ""
    var secondEntryPassword = ""

   
    private let scrollView : UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
       return scroll
    }()
    
    private let mainView:  UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Come up with a password"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "   Enter Password"
        textField.clearButtonMode = .whileEditing
        textField.layer.borderWidth = 3
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowRadius = 3
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowOffset = CGSize(width: 2, height: 2)
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16)
        textField.isSecureTextEntry = true
        
       
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 1
        button.setTitle("Create password", for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.borderWidth = 3
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 3
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(mainView)
        mainView.addSubview(loginLabel)
        mainView.addSubview(loginTextField)
        mainView.addSubview(loginButton)
        addConstraints()
      }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
        
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mainView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            mainView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            loginLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 100),
            loginLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            loginLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            loginLabel.heightAnchor.constraint(equalToConstant: 30),
                                            
            
            loginTextField.topAnchor.constraint(equalTo: loginLabel.topAnchor, constant: 150),
            loginTextField.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            loginTextField.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 40),
            loginTextField.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -40),
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 15),
            loginButton.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 40),
            loginButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -40),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
           
        ])
}
    //MARK: кнопка
    @objc private func buttonTapped() {
        if loginButton.tag == 1 {
            firstLogin()
        } else
        if loginButton.tag == 2 {
            confirmLogin()
        } else
        if loginButton.tag == 3 {
            login()
        }
        
    }
    
    // MARK: Keyboard
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let theme = UserDefaults.standard.bool(forKey: "blackTheme")
        if theme == true {
            view.backgroundColor = .darkGray
        } else {
            view.backgroundColor = .white
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }

    
    func firstLogin() {
        entryPassword = loginTextField.text ?? ""
        
        guard entryPassword != ""
        else {
            showAlertController(message: "you need to enter a password")
            return
        }
        
        guard entryPassword.count > 3
        else {
            loginTextField.text = ""
            showAlertController(message: "the password must contain more than 4 characters")
            return
        }
        
        loginLabel.text = "Repeat your password"
        loginButton.setTitle("Confirm", for: .normal)
        firstEntryPassword = entryPassword
        loginTextField.text = ""
        loginButton.tag = 2
    }
    
    
    func confirmLogin() {
        if loginTextField.text == "" {
            showAlertController(message: "you need to confirm a password")
        } else {
            secondEntryPassword = loginTextField.text ?? ""
        }
        if secondEntryPassword == firstEntryPassword {
            loginLabel.text = "Autorization"
            loginButton.setTitle("Sign in", for: .normal)
            ShowSucsessAlert()
          //  - перенес сохранение в keychain на кнопку "OK" в алерте
        
            loginButton.tag = 3
        } else {
            showAlertController(message: "The password does not match: \n Please check the correctness of the input")
            loginTextField.text = ""
        }
    }
    
    func login() {
        if loginTextField.text == secondEntryPassword {
            loginTextField.text = ""
            let tabBarController = TabBarController()
            navigationController?.pushViewController(tabBarController, animated: true)
        } else {
            showAlertController(message: "Wrong password!")
            loginTextField.text = ""
        }
    }
    
    
    
    //MARK: Алерт
    private func showAlertController(message: String) {
        let alertController = UIAlertController(title: "Error",
                                                message: message,
                                                preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Ok",
                                          style: .cancel,
                                          handler: nil)
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func ShowSucsessAlert() {
        let alertController = UIAlertController(title: "Password successfully created",
                                                message: "Do you want to save it?",
                                                preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: { [self] _ in
            try? keychain.set(secondEntryPassword, key: "savePassword")
            let tabBarController = TabBarController()
            navigationController?.pushViewController(tabBarController, animated: true)
                                                    }) //если ОК, то сохраняем в keychain
      
        let cencelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler:{ [self] _ in
            loginTextField.text = "" }) // и не передаём в keychain
        
        alertController.addAction(cencelAction)
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
}

