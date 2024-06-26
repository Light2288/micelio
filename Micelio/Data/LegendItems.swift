//
//  LegendItems.swift
//  Micelio
//
//  Created by Davide Aliti on 03/11/23.
//

import SwiftUI

let legendItems: [LegendItem] = [
    LegendItem(icon: Edibility.edible.rawValue.removeWhitespacesAndLowercase, iconColor: Color("CustomSecondaryColor"), text: Edibility.edible.rawValue, legendSection: legendSections[0]),
    LegendItem(icon: Edibility.edibleAfterCooking.rawValue.removeWhitespacesAndLowercase, iconColor: Color("CustomSecondaryColor"), text: Edibility.edibleAfterCooking.rawValue, legendSection: legendSections[0]),
    LegendItem(icon: Edibility.edibleWithoutAlcohol.rawValue.removeWhitespacesAndLowercase, iconColor: Color("CustomSecondaryColor"), text: Edibility.edibleWithoutAlcohol.rawValue, legendSection: legendSections[0]),
    LegendItem(icon: Edibility.noValue.rawValue.removeWhitespacesAndLowercase, iconColor: .orange, text: Edibility.noValue.rawValue, legendSection: legendSections[0]),
    LegendItem(icon: Edibility.poisonous.rawValue.removeWhitespacesAndLowercase, iconColor: .red, text: Edibility.poisonous.rawValue, legendSection: legendSections[0]),
    LegendItem(icon: Edibility.deadly.rawValue.removeWhitespacesAndLowercase, iconColor: .red, text: Edibility.deadly.rawValue, legendSection: legendSections[0]),
    LegendItem(icon: MushroomEnvironment.broadLeavedForest.rawValue.removeWhitespacesAndLowercase, iconColor: Color("CustomSecondaryColor"), text: MushroomEnvironment.broadLeavedForest.rawValue, legendSection: legendSections[1]),
    LegendItem(icon: MushroomEnvironment.coniferousForest.rawValue.removeWhitespacesAndLowercase, iconColor: Color("CustomSecondaryColor"), text: MushroomEnvironment.coniferousForest.rawValue, legendSection: legendSections[1]),
    LegendItem(icon: MushroomEnvironment.field.rawValue.removeWhitespacesAndLowercase, iconColor: Color("CustomSecondaryColor"), text: MushroomEnvironment.field.rawValue, legendSection: legendSections[1]),
    LegendItem(icon: MushroomEnvironment.lignicolous.rawValue.removeWhitespacesAndLowercase, iconColor: Color("CustomSecondaryColor"), text: MushroomEnvironment.lignicolous.rawValue, legendSection: legendSections[1]),
    LegendItem(icon: Season.spring.rawValue.removeWhitespacesAndLowercase, iconColor: Color("CustomSecondaryColor"), text: Season.spring.rawValue, legendSection: legendSections[2]),
    LegendItem(icon: Season.summer.rawValue.removeWhitespacesAndLowercase, iconColor: Color("CustomSecondaryColor"), text: Season.summer.rawValue, legendSection: legendSections[2]),
    LegendItem(icon: Season.autumn.rawValue.removeWhitespacesAndLowercase, iconColor: Color("CustomSecondaryColor"), text: Season.autumn.rawValue, legendSection: legendSections[2]),
    LegendItem(icon: Season.winter.rawValue.removeWhitespacesAndLowercase, iconColor: Color("CustomSecondaryColor"), text: Season.winter.rawValue, legendSection: legendSections[2])
]
