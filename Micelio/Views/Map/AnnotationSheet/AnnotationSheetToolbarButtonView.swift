//
//  AnnotationSheetToolbarButtonView.swift
//  Micelio
//
//  Created by Davide Aliti on 11/12/24.
//

import SwiftUI

struct AnnotationSheetToolbarButtonView: View {
    let role: ButtonRole?
    let action: () -> Void
    let labelImageSystemName: String
    let labelImageSymbolVariant: SymbolVariants
    let labelImageScale: Image.Scale
    
    var body: some View {
        Button(
            role: role,
            action: action,
            label: {
                Image(systemName: labelImageSystemName)
                    .symbolVariant(labelImageSymbolVariant)
                    .imageScale(labelImageScale)
                    .font(.title)
            })
    }
}

#Preview {
    AnnotationSheetToolbarButtonView(role: nil, action: { return }, labelImageSystemName: "pencil", labelImageSymbolVariant: .none, labelImageScale: .medium)
}
