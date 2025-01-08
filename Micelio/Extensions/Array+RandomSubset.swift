//
//  Array+RandomSubset.swift
//  Micelio
//
//  Created by Davide Aliti on 31/10/24.
//

import Foundation

extension Array {
    func randomSubset() -> [Element] {
        Array(self.shuffled().prefix(Int.random(in: 1...self.count)))
    }
}
