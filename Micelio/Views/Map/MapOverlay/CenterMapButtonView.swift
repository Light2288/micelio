//
//  CenterMapButtonView.swift
//  Micelio
//
//  Created by Davide Aliti on 07/02/24.
//

import SwiftUI

struct CenterMapButtonView: View {
    var centerOnUserPosition: () -> Void
    
    private let frameSize: CGFloat = Constants.MushroomMap.CenterMapButton.frameSize
    
    var body: some View {
        Button {
            centerOnUserPosition()
        } label: {
            Image(systemName: "location.fill")
                .resizableImageWithShapeBackground(shape: AnyShape(Circle()), frameWidth: frameSize, frameHeight: frameSize, padding: .zero)
        }
    }
}

#Preview {
    func centerOnUserPosition() { }
    
    return CenterMapButtonView(centerOnUserPosition: centerOnUserPosition)
}
