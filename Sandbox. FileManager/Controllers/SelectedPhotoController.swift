//
//  SelectedPhotoController.swift
//  Sandbox. FileManager
//
//  Created by Oleg Popov on 13.12.2022.
//

import Foundation
import UIKit


class SelectedPhotoController: UIViewController {
    
    let imageView: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(imageView)
        addConstraints()
    }
    
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
            
            ])
    }
    
}
