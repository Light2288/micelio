//
//  PinColorChoiceView.swift
//  Micelio
//
//  Created by Davide Aliti on 10/03/24.
//

import SwiftUI

struct PinColorChoiceView: View {
    @Binding var selectedColor: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Scegli il colore del segnaposto")
                .font(.subheadline)
            HStack {
                ForEach(Array(MushroomMapAnnotation.colors.keys.sorted()), id: \.self) { colorString in
                    Button(action: {
                        selectedColor = colorString
                    }, label: {
                        PinColorChoiceButtonLabelView(colorString: colorString, selectedColor: $selectedColor)
                    })
                }
            }
        }
    }
}

#Preview {
    PinColorChoiceView(selectedColor: .constant("accent"))
}
