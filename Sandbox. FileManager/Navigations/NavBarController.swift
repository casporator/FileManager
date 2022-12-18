//
//  NavBarController.swift
//  Sandbox. FileManager
//
//  Created by Oleg Popov on 11.12.2022.
//

import Foundation
import UIKit

final class NavBarController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        
        view.backgroundColor = .white
        navigationBar.isTranslucent = false
       
        
        navigationBar.addBottomBorder(with: .darkGray, with: 1)
        
    }
}

extension UIView {
    //MARK: добавляю линию под навбаром
    func addBottomBorder(with color: UIColor, with height: CGFloat) {
        let seporator = UIView()
        seporator.backgroundColor = color
        seporator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        seporator.frame = CGRect(x: 0,
                                 y: frame.height - height,
                                 width: frame.width,
                                 height: height)
        addSubview(seporator)
    }
}
