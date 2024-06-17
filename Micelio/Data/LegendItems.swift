//
//  LegendItems.swift
//  Micelio
//
//  Created by Davide Aliti on 03/11/23.
//

import SwiftUI

let legendItems: [LegendItem] = [
    LegendItem(icon: "edible", iconColor: Color("CustomSecondaryColor"), text: Edibility.edible.edibilityTitle, legendSection: legendSections[0]),
    LegendItem(icon: "edibleAfterCooking", iconColor: Color("CustomSecondaryColor"), text: Edibility.edibleAfterCooking.edibilityTitle, legendSection: legendSections[0]),
    LegendItem(icon: "edibleWithoutAlcohol", iconColor: Color("CustomSecondaryColor"), text: Edibility.edibleWithoutAlcohol.edibilityTitle, legendSection: legendSections[0]),
    LegendItem(icon: "noValue", iconColor: .orange, text: Edibility.noValue.edibilityTitle, legendSection: legendSections[0]),
    LegendItem(icon: "poisonous", iconColor: .red, text: Edibility.poisonous.edibilityTitle, legendSection: legendSections[0]),
    LegendItem(icon: "deadly", iconColor: .red, text: Edibility.deadly.edibilityTitle, legendSection: legendSections[0]),
    LegendItem(icon: "broadLeavedForest", iconColor: Color("CustomSecondaryColor"), text: MushroomEnvironment.broadLeavedForest.environmentTitle, legendSection: legendSections[1]),
    LegendItem(icon: "coniferousForest", iconColor: Color("CustomSecondaryColor"), text: MushroomEnvironment.coniferousForest.environmentTitle, legendSection: legendSections[1]),
    LegendItem(icon: "field", iconColor: Color("CustomSecondaryColor"), text: MushroomEnvironment.field.environmentTitle, legendSection: legendSections[1]),
    LegendItem(icon: "lignicolous", iconColor: Color("CustomSecondaryColor"), text: MushroomEnvironment.lignicolous.environmentTitle, legendSection: legendSections[1]),
    LegendItem(icon: "spring", iconColor: Color("CustomSecondaryColor"), text: Season.spring.seasonTitle, legendSection: legendSections[2]),
    LegendItem(icon: "summer", iconColor: Color("CustomSecondaryColor"), text: Season.summer.seasonTitle, legendSection: legendSections[2]),
    LegendItem(icon: "autumn", iconColor: Color("CustomSecondaryColor"), text: Season.autumn.seasonTitle, legendSection: legendSections[2]),
    LegendItem(icon: "winter", iconColor: Color("CustomSecondaryColor"), text: Season.winter.seasonTitle, legendSection: legendSections[2])
]
