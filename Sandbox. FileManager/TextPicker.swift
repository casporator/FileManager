//
//  TextPicker.swift
//  Sandbox. FileManager
//
//  Created by Oleg Popov on 11.12.2022.
//

import Foundation
import UIKit

class TextPicker {
    //создаю синглтон
    static let defaaultPicker = TextPicker()
    
    func showPicker(in viewController: UIViewController, complition: @escaping(_ text: String) -> Void) {
        let alertController = UIAlertController(title: "Enter name", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Enter text"
        }
        let actionOk = UIAlertAction(title: "Ok", style: .default) { action in
            if let text = alertController.textFields?[0].text,
               text != "" {
                complition(text)
            }
        }
        let octionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(actionOk)
        alertController.addAction(octionCancel)
        
        viewController.present(alertController, animated: true)
    }
}
