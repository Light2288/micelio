//
//  FloatingPoint+Rounded.swift
//  Micelio
//
//  Created by Davide Aliti on 28/12/23.
//

import Foundation

extension FloatingPoint where Self: CVarArg, Self: LosslessStringConvertible {
    func roundTo(places: Int) -> Self {
        let roundedString = String(format: "%.\(places)f", self)
        return Self(roundedString) ?? 0
    }
}
