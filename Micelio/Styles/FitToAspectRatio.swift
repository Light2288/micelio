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
