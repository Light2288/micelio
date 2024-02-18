//
//  MushroomPinView.swift
//  Micelio
//
//  Created by Davide Aliti on 09/02/24.
//

import SwiftUI

struct MushroomPinView: View {
    let mushroomMapAnnotation: MushroomMapAnnotation
    
    var body: some View {
        Image("mushroom-pin")
            .resizable()
            .scaledToFit()
            .foregroundStyle(MushroomMapAnnotation.colors[mushroomMapAnnotation.color ?? "accent"] ?? .accent)
            .shadow(color: Color(.systemBackground), radius: Constants.MushroomMap.MushroomPin.shadowRadius)
            .frame(height: Constants.MushroomMap.MushroomPin.frameHeight)
            .offset(y: -Constants.MushroomMap.MushroomPin.frameHeight/2)
    }
}

#Preview {
    MushroomPinView(mushroomMapAnnotation: MushroomMapAnnotation(context: PersistenceController.preview.container.viewContext))
}
