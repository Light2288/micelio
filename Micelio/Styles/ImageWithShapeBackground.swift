//
//  ImageWithShapeBackground.swift
//  Micelio
//
//  Created by Davide Aliti on 18/12/23.
//

import Foundation
import SwiftUI

struct ImageWithShapeBackground: ViewModifier {
    var shape: AnyShape
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.accentColor)
            .foregroundColor(Color(.systemBackground))
            .clipShape(shape)
            .shadow(radius: 8)
    }
}

extension View {
    func imageWithShapeBackground(shape: AnyShape) -> some View {
        modifier(ImageWithShapeBackground(shape: shape))
    }
}
