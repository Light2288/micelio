//
//  CenterMapButtonView.swift
//  Micelio
//
//  Created by Davide Aliti on 07/02/24.
//

import SwiftUI

struct CenterMapButtonView: View {
    var centerOnUserPosition: () -> Void
    
    var body: some View {
        Button {
            centerOnUserPosition()
        } label: {
            Image(systemName: "location.fill")
                .resizableImageWithShapeBackground(shape: AnyShape(Circle()), frameWidth: Constants.MushroomMap.CenterMapButton.frameSize, frameHeight: Constants.MushroomMap.CenterMapButton.frameSize, padding: .zero)
        }
    }
}

#Preview {
    func centerOnUserPosition() { }
    
    return CenterMapButtonView(centerOnUserPosition: centerOnUserPosition)
}
