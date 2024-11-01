//
//  Image+FitToAspectRatio.swift
//  Micelio
//
//  Created by Davide Aliti on 31/10/24.
//

import SwiftUI

extension Image {
    func fitToAspect(_ aspectRatio: Double = 1, contentMode: SwiftUI.ContentMode = .fill) -> some View {
        self.resizable()
            .scaledToFill()
            .modifier(FitToAspectRatio(aspectRatio: aspectRatio, contentMode: contentMode))
    }
}
