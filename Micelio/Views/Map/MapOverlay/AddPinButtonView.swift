//
//  AddPinButtonView.swift
//  Micelio
//
//  Created by Davide Aliti on 07/02/24.
//

import SwiftUI

struct AddPinButtonView: View {
    @Binding var mushroomLocations: [MushroomMapAnnotation]
    var addPinToMapCenter: (CGSize) -> MushroomMapAnnotation
    var size: CGSize
    
    var body: some View {
        Button {
            mushroomLocations.append(addPinToMapCenter(size))
        } label: {
            Image(systemName: "mappin.and.ellipse")
                .resizableImageWithShapeBackground(shape: AnyShape(Circle()), frameWidth: Constants.MushroomMap.AddPinButton.frameSize, frameHeight: Constants.MushroomMap.AddPinButton.frameSize, padding: .zero)
        }
    }
}

#Preview {
    func addPinToMapCenter(size: CGSize) -> MushroomMapAnnotation {
        return MushroomMapAnnotation(latitude: 0, longitude: 0)
    }
    
    return GeometryReader { proxy in
        AddPinButtonView(mushroomLocations: .constant([]), addPinToMapCenter: addPinToMapCenter, size: proxy.size)
    }
}
