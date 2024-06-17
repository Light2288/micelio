//
//  Season.swift
//  Micelio
//
//  Created by Davide Aliti on 10/10/23.
//

import Foundation

enum Season: String, CaseIterable, Identifiable {
    
    var id: String { return self.rawValue }
    
    var seasonTitle: String {
        switch self {
        case .spring:
            "Primavera"
        case .summer:
            "Estate"
        case .autumn:
            "Autunno"
        case .winter:
            "Inverno"
        }
    }
    
    case spring
    case summer
    case autumn
    case winter
}
