//
//  AddPinButtonView.swift
//  Micelio
//
//  Created by Davide Aliti on 07/02/24.
//

import SwiftUI

struct AddPinButtonView: View {
    @Binding var showSheet: Bool
    
    var addPinToMapCenter: (CGSize) -> Void
    var size: CGSize
    
    var body: some View {
        Button {
            addPinToMapCenter(size)
        } label: {
            Image("mushroom-pin")
                .resizableImageWithShapeBackground(shape: AnyShape(Circle()), frameWidth: Constants.MushroomMap.AddPinButton.frameSize, frameHeight: Constants.MushroomMap.AddPinButton.frameSize, padding: Constants.MushroomMap.AddPinButton.padding)
        }
    }
}

#Preview {
    func addPinToMapCenter(size: CGSize) { }
    
    return GeometryReader { proxy in
        AddPinButtonView(showSheet: .constant(false), addPinToMapCenter: addPinToMapCenter, size: proxy.size)
    }
}
