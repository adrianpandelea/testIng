//
//  UITableViewCell+Ext.swift
//  Test
//
//  Created by Adrian Pandelea on 04.06.2024.
//

import Foundation
import UIKit

extension UITableViewCell {
    @objc class var identifier: String {
        return String(describing: self)
    }
}
