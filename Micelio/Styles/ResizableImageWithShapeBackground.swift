//
//  ResizableImageWithShapeBackground.swift
//  Micelio
//
//  Created by Davide Aliti on 29/12/23.
//

import Foundation
import SwiftUI

extension Image {
    func resizableImageWithShapeBackground(shape: AnyShape, frameWidth: CGFloat, frameHeight: CGFloat) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(Constants.Styles.ResizableImageWithShapeBackground.padding)
            .viewWithShapeBackground(shape: shape, width: frameWidth, height: frameHeight)
    }
}
