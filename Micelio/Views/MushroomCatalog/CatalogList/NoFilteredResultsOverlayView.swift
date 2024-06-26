//
//  NoFilteredResultsOverlayView.swift
//  Micelio
//
//  Created by Davide Aliti on 26/06/24.
//

import SwiftUI

struct NoFilteredResultsOverlayView: View {
    var body: some View {
        VStack {
            Image("noResults")
                .resizable()
                .scaledToFit()
                .frame(
                    width: Constants.MushroomCatalog.NoFilteredResults.imageFrameDimension,
                    height: Constants.MushroomCatalog.NoFilteredResults.imageFrameDimension
                )
            Text("Ooops!")
                .font(.title)
                .padding()
            Text("Sembra non ci sia nessun fungo che rispetti i filtri applicati")
                .font(.title3)
                .multilineTextAlignment(.center)
            
        }
        .padding()
        .foregroundStyle(.accent)
    }
}

#Preview {
    NoFilteredResultsOverlayView()
}
