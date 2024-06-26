//
//  Array+Intersect.swift
//  Micelio
//
//  Created by Davide Aliti on 25/06/24.
//

import Foundation

extension Array where Element : Hashable {
    func isDisjoint(with secondArray: [Element]) -> Bool {
        return Set(self).isDisjoint(with: Set(secondArray))
    }
}
