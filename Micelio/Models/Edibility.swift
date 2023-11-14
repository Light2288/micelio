//
//  Edibility.swift
//  Micelio
//
//  Created by Davide Aliti on 10/10/23.
//

import Foundation

enum Edibility: String, CaseIterable, Identifiable {
    
    var id: String { return self.rawValue }
    
    case edible
    case edibleAfterCooking
    case edibleWithoutAlcohol
    case noValue
    case poisonous
    case deadly
}
