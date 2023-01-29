//
//  Extensions.swift
//  Netflix
//
//  Created by Rivaldo Fernandes on 29/01/23.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
