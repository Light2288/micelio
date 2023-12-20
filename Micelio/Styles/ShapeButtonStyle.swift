//
//  ShapeButtonStyle.swift
//  Micelio
//
//  Created by Davide Aliti on 15/12/23.
//

import Foundation
import SwiftUI

struct ShapeButtonStyle: ButtonStyle {
    let shape: AnyShape
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.accentColor)
            .foregroundColor(Color(.systemBackground))
            .clipShape(shape)
            .shadow(radius: 8)
    }
}
