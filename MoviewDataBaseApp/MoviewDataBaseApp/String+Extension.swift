//
//  String+Extension.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 06/10/23.
//

import Foundation

extension String {
    
    func isNotEmpty() -> Bool {
        return self != "" && self != "N/A"
    }
}
