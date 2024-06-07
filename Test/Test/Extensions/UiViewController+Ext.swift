//
//  UiViewController+Ext.swift
//  Test
//
//  Created by Adrian Pandelea on 04.06.2024.
//

import Foundation
import UIKit

extension UIViewController {
    func presentAlert(title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc class var identifier: String {
        return String(describing: self)
    }
}
