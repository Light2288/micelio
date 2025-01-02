//
//  DetailSection.swift
//  Micelio
//
//  Created by Davide Aliti on 02/01/25.
//

import Foundation

struct DetailSection: Identifiable {
    let id = UUID()
    let title: String
    let content: String
    let image: String
}
