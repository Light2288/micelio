//
//  ImageWithShapeBackground.swift
//  Micelio
//
//  Created by Davide Aliti on 18/12/23.
//

import Foundation
import SwiftUI

struct ViewWithShapeBackground: ViewModifier {
    var shape: AnyShape
    var frameWidth: CGFloat
    var frameHeight: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(width: frameWidth, height: frameHeight)
            .background(Color.accentColor)
            .foregroundColor(Color(.systemBackground))
            .clipShape(shape)
            .shadow(radius: Constants.Styles.ViewWithShapeBackground.shadowRadius)
    }
}
