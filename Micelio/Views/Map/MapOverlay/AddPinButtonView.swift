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
    
    private let frameSize: CGFloat = Constants.MushroomMap.AddPinButton.frameSize
    private let padding: CGFloat = Constants.MushroomMap.AddPinButton.padding
    
    var body: some View {
        Button {
            addPinToMapCenter(size)
        } label: {
            Image("mushroom-pin")
                .resizableImageWithShapeBackground(shape: AnyShape(Circle()), frameWidth: frameSize, frameHeight: frameSize, padding: padding)
        }
    }
}

#Preview {
    func addPinToMapCenter(size: CGSize) { }
    
    return GeometryReader { proxy in
        AddPinButtonView(showSheet: .constant(false), addPinToMapCenter: addPinToMapCenter, size: proxy.size)
    }
}
