//
//  String+LowercaseFirstChar.swift
//  Micelio
//
//  Created by Davide Aliti on 18/03/24.
//

import Foundation

extension String {
    var lowercaseFirstChar: String {
        let firstLetter = self.prefix(1).lowercased()
        let remainingLetters = self.dropFirst()
        return firstLetter + remainingLetters
    }
}
