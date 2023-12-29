//
//  Float+Rounded.swift
//  Micelio
//
//  Created by Davide Aliti on 28/12/23.
//

import Foundation

extension Float {
    func roundTo(places: Int) -> Float {
        let floatString = String(format: "%.\(places)f", self)
        return Float(floatString) ?? 0
    }
}
