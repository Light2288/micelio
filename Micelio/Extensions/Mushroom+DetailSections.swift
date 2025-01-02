//
//  Mushroom+DetailSections.swift
//  Micelio
//
//  Created by Davide Aliti on 02/01/25.
//

import Foundation

extension Mushroom {
    
    func detailSections() -> [DetailSection] {
        return
            [
                DetailSection(title: "Descrizione", content: self.description, image: "disclosuregroup-description"),
                DetailSection(title: "Commestibilità", content: self.edibilityDescription, image: "disclosuregroup-edibility"),
                DetailSection(title: "Habitat", content: self.environmentDescription, image: "disclosuregroup-habitat"),
                DetailSection(title: "Curiosità", content: self.trivia, image: "disclosuregroup-trivia")
            ]
        
    }
}
