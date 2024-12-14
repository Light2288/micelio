//
//  AddMushroomLocationTextView.swift
//  Micelio
//
//  Created by Davide Aliti on 07/02/24.
//

import SwiftUI

struct AddMushroomLocationTextView: View {
    var size: CGSize
    
    private let maxWidthCorrectionRatio: CGFloat = Constants.MushroomMap.AddMushroomLocationText.maxWidthCorrectionRatio
    private let maxWidth: CGFloat = Constants.MushroomMap.AddMushroomLocationText.maxWidth
    
    var body: some View {
        Text("Per inserire la posizione di un fungo, premi due volte sulla mappa o usa il tasto in basso a destra")
            .font(.caption2)
            .fontWeight(.semibold)
            .multilineTextAlignment(.center)
            .frame(maxWidth: min(size.width/maxWidthCorrectionRatio, maxWidth))
            .padding()
            .background {
                Capsule()
                    .fill(.ultraThinMaterial)
            }
    }
}

#Preview {
    GeometryReader { proxy in
        AddMushroomLocationTextView(size: proxy.size)
    }
}
