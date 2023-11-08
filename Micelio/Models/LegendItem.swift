//
//  LegendItem.swift
//  Micelio
//
//  Created by Davide Aliti on 03/11/23.
//

import SwiftUI

struct LegendItem: Identifiable {
    let id = UUID()
    let icon: String
    let iconColor: Color
    let text: String
    let legendSection: LegendSection
}
