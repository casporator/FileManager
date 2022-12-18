//
//  SettingsViewController.swift
//  Sandbox. FileManager
//
//  Created by Oleg Popov on 11.12.2022.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {

    var sortMethod : Bool {
        get {
            return UserDefaults.standard.bool(forKey: "sortStatus")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "sortStatus")
        }
    }
    
    var blackTheme : Bool {
        get {
            return UserDefaults.standard.bool(forKey: "blackTheme")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "blackTheme")
        }
    }
    
    private lazy var sortLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sort files by \("A..Z")"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()

    private lazy var sortSwitcher : UISwitch = {
        let switcher = UISwitch()
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.addTarget(self, action: #selector(setSort), for: .valueChanged)
        return switcher
    }()
    
    private lazy var themeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Dark theme"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private lazy var themeSwitcher : UISwitch = {
        let switcher = UISwitch()
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.addTarget(self, action: #selector(setTheme), for: .valueChanged)
        return switcher
    }()

    private lazy var pswdButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(" Change password ", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.borderWidth = 3
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.addTarget(self, action: #selector(changePassword), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
     
        self.title = "Settings"
        addConstraints()
        

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    
        
        if sortMethod == true {
            sortSwitcher.isOn = true
        } else {
            sortSwitcher.isOn = false
        }
        
        if blackTheme == true {
            themeSwitcher.isOn = true
        } else {
            themeSwitcher.isOn = false
        }
        
        
    }
    
    func addConstraints(){
        view.addSubview(sortLabel)
        view.addSubview(sortSwitcher)
        view.addSubview(themeLabel)
        view.addSubview(themeSwitcher)
        view.addSubview(pswdButton)
        
        NSLayoutConstraint.activate([
            
            sortLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            sortLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),

            sortSwitcher.centerYAnchor.constraint(equalTo: sortLabel.centerYAnchor),
            sortSwitcher.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            themeLabel.topAnchor.constraint(equalTo: sortLabel.bottomAnchor, constant: 20),
            themeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            themeSwitcher.centerYAnchor.constraint(equalTo: themeLabel.centerYAnchor),
            themeSwitcher.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),

            pswdButton.topAnchor.constraint(equalTo: themeLabel.bottomAnchor, constant: 20),
            pswdButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
        
        ])
        
    }
    
    @objc
    func changePassword(){
        let vc = LoginViewController()
   present(vc, animated: true)
    }
    
    
    @objc
    func setSort(){
        if sortSwitcher.isOn {
            sortMethod = true
        } else {
            sortMethod = false
        }
    }
    
    @objc
    func setTheme(){
        if themeSwitcher.isOn {
            blackTheme = true
            view.backgroundColor = .darkGray
        } else {
            blackTheme = false
            view.backgroundColor = .white
        }
    }
    
    
}
    



