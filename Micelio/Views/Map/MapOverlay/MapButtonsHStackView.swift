//
//  MapButtonsHStackView.swift
//  Micelio
//
//  Created by Davide Aliti on 07/02/24.
//

import SwiftUI

struct MapButtonsHStackView: View {
    var addPinToMapCenter: (CGSize) -> Void
    var centerOnUserPosition: () -> Void
    var size: CGSize
    
    @Binding var showSheet: Bool
    
    var body: some View {
        HStack {
            CenterMapButtonView(centerOnUserPosition: centerOnUserPosition)
            Spacer()
            AddPinButtonView(showSheet: $showSheet, addPinToMapCenter: addPinToMapCenter, size: size)
        }
    }
}

#Preview {
    func centerOnUserPosition() { }
    
    func addPinToMapCenter(size: CGSize) { }
    
    return GeometryReader { proxy in
        MapButtonsHStackView(addPinToMapCenter: addPinToMapCenter, centerOnUserPosition: centerOnUserPosition, size: proxy.size, showSheet: .constant(false))
    }
        
}
