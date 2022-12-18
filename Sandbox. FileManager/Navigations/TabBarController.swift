//
//  TabBarController.swift
//  Sandbox. FileManager
//
//  Created by Oleg Popov on 11.12.2022.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super .init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        tabBar.tintColor = .systemCyan
        tabBar.barTintColor = .gray
        tabBar.backgroundColor = .white
        tabBar.layer.borderColor = UIColor.darkGray.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
        
        let fileVC = FileViewController()
        let settingsVC = SettingsViewController()
  
        
        let fileNavigation = NavBarController(rootViewController: fileVC)
        let settingsNavigation = NavBarController(rootViewController: settingsVC)
       
        
        
        
        fileVC.tabBarItem = UITabBarItem(title: "File", image: UIImage(systemName: "doc.badge.ellipsis"),
                                         tag: 0)
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "wrench.and.screwdriver"),
                                             tag: 1)

        
        
        
        setViewControllers([fileNavigation, settingsNavigation], animated: true)
    }
}
