//
//  Season.swift
//  Micelio
//
//  Created by Davide Aliti on 10/10/23.
//

import Foundation

enum Season: String, CaseIterable, Identifiable {
    
    var id: String { return self.rawValue }
    
    case spring
    case summer
    case autumn
    case winter
}
