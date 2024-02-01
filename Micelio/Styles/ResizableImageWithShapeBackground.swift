//
//  ResizableImageWithShapeBackground.swift
//  Micelio
//
//  Created by Davide Aliti on 29/12/23.
//

import Foundation
import SwiftUI

extension Image {
    func resizableImageWithShapeBackground(shape: AnyShape, frameWidth: CGFloat, frameHeight: CGFloat, padding: CGFloat = Constants.Styles.ResizableImageWithShapeBackground.padding) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(padding)
            .viewWithShapeBackground(shape: shape, width: frameWidth, height: frameHeight)
    }
}
