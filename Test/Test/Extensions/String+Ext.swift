//
//  String+Ext.swift
//  Test
//
//  Created by Adrian Pandelea on 05.06.2024.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
