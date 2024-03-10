//
//  AnnotationSheetButtonHStackView.swift
//  Micelio
//
//  Created by Davide Aliti on 21/02/24.
//

import SwiftUI

struct AnnotationSheetButtonHStackView: View {
    @Binding var isAnnotationEditMode: Bool
    
    var body: some View {
        HStack(spacing: Constants.MushroomMap.AnnotationSheet.ButtonHStack.spacing) {
            Spacer()
            Button(action: {
                isAnnotationEditMode.toggle()
            }, label: {
                Image(systemName: "pencil")
                    .symbolVariant(isAnnotationEditMode ? .slash : .fill)
                    .imageScale(.medium)
                    .font(.title)
            })

            Button(action: {
                
            }, label: {
                Image(systemName: "trash")
                    .symbolVariant(.fill)
                    .imageScale(.small)
                    .font(.title)
            })
        }
        .padding(.bottom, Constants.MushroomMap.AnnotationSheet.ButtonHStack.bottomPadding)
    }
}

#Preview {
    AnnotationSheetButtonHStackView(isAnnotationEditMode: .constant(true))
}
