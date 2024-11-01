//
//  View+ShapeBackground.swift
//  Micelio
//
//  Created by Davide Aliti on 31/10/24.
//

import SwiftUI

extension View {
    func viewWithShapeBackground(shape: AnyShape, width: CGFloat, height: CGFloat) -> some View {
        modifier(ViewWithShapeBackground(shape: shape, frameWidth: width, frameHeight: height))
    }
}
