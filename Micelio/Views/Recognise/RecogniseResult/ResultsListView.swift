//
//  ResultsListView.swift
//  Micelio
//
//  Created by Davide Aliti on 10/01/24.
//

import SwiftUI

struct ResultsListView: View {
    var recognisedMushrooms: [RecognisedMushroom]
    
    var otherResults: [RecognisedMushroom] {
        Array(recognisedMushrooms.dropFirst())
    }
    
    var body: some View {
        if let firstResult = recognisedMushrooms.first {
            VStack {
                MainResultView(firstResult: firstResult)
                
                if !otherResults.isEmpty {
                    OtherResultsView(otherResults: Array(recognisedMushrooms.dropFirst()))
                }
            }
        } else {
            Text("Non è stato possibile riconoscere alcun fungo dalla fotografia utilizzata")
                .font(.title2)
                .multilineTextAlignment(.center)
        }
        
    }
}

#Preview {
    ResultsListView(recognisedMushrooms: [
        RecognisedMushroom(mushroomIdentifier: "Boletus Edulis", confidence: 0.98569),
        RecognisedMushroom(mushroomIdentifier: "Boletus Edulis", confidence: 0.98569),
        RecognisedMushroom(mushroomIdentifier: "Amanita Muscaria", confidence: 0.1945)
    ])
}
