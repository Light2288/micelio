//
//  String+LowercasedNoWhitespaces.swift
//  Micelio
//
//  Created by Davide Aliti on 25/06/24.
//

import Foundation

import Foundation

extension String {
    var removeWhitespacesAndLowercase: String {
        return self.localizedLowercase.filter{ !$0.isWhitespace }
    }
}
