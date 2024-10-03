//
//  FitToAspectRatio.swift
//  Micelio
//
//  Created by Davide Aliti on 13/09/24.
//

import SwiftUI

struct FitToAspectRatio: ViewModifier {

    let aspectRatio: Double
    let contentMode: SwiftUI.ContentMode

    func body(content: Content) -> some View {
        Color.clear
            .aspectRatio(aspectRatio, contentMode: .fit)
            .overlay(
                content.aspectRatio(nil, contentMode: contentMode)
            )
            .clipShape(Rectangle())
    }

}

extension Image {
    func fitToAspect(_ aspectRatio: Double = 1, contentMode: SwiftUI.ContentMode = .fill) -> some View {
        self.resizable()
            .scaledToFill()
            .modifier(FitToAspectRatio(aspectRatio: aspectRatio, contentMode: contentMode))
    }
}
