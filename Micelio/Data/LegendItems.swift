//
//  LegendItems.swift
//  Micelio
//
//  Created by Davide Aliti on 03/11/23.
//

import SwiftUI

let legendItems: [LegendItem] = [
    LegendItem(icon: "edible", iconColor: Color("CustomSecondaryColor"), text: "Commestibile", legendSection: legendSections[0]),
    LegendItem(icon: "edibleAfterCooking", iconColor: Color("CustomSecondaryColor"), text: "Commestibile dopo cottura", legendSection: legendSections[0]),
    LegendItem(icon: "edibleWithoutAlcohol", iconColor: Color("CustomSecondaryColor"), text: "Commestibile senza alcolici", legendSection: legendSections[0]),
    LegendItem(icon: "noValue", iconColor: .orange, text: "Nessun valore", legendSection: legendSections[0]),
    LegendItem(icon: "poisonous", iconColor: .red, text: "Velenoso", legendSection: legendSections[0]),
    LegendItem(icon: "deadly", iconColor: .red, text: "Velenoso mortale", legendSection: legendSections[0]),
    LegendItem(icon: "broadLeavedForest", iconColor: Color("CustomSecondaryColor"), text: "Foreste di latifoglie", legendSection: legendSections[1]),
    LegendItem(icon: "coniferousForest", iconColor: Color("CustomSecondaryColor"), text: "Foreste di conifere", legendSection: legendSections[1]),
    LegendItem(icon: "field", iconColor: Color("CustomSecondaryColor"), text: "Prati", legendSection: legendSections[1]),
    LegendItem(icon: "lignicolous", iconColor: Color("CustomSecondaryColor"), text: "Lignicolo", legendSection: legendSections[1]),
    LegendItem(icon: "spring", iconColor: Color("CustomSecondaryColor"), text: "Primavera", legendSection: legendSections[2]),
    LegendItem(icon: "summer", iconColor: Color("CustomSecondaryColor"), text: "Estate", legendSection: legendSections[2]),
    LegendItem(icon: "autumn", iconColor: Color("CustomSecondaryColor"), text: "Autunno", legendSection: legendSections[2]),
    LegendItem(icon: "winter", iconColor: Color("CustomSecondaryColor"), text: "Inverno", legendSection: legendSections[2])
]
