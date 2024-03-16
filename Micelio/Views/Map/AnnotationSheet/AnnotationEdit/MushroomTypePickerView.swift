//
//  MushroomTypePickerView.swift
//  Micelio
//
//  Created by Davide Aliti on 10/03/24.
//

import SwiftUI

struct MushroomTypePickerView: View {
    @Binding var selectedMushroomName: String
    
    var mushroomNames: [String]
    
    var body: some View {
        HStack {
            Text("Tipologia fungo:")
            Menu {
                Picker(selection: $selectedMushroomName) {
                    ForEach(mushroomNames, id: \.self) {
                        Text($0)
                    }
                } label: {}
            } label: {
                HStack {
                    Text(selectedMushroomName)
                    Image(systemName: "chevron.up.chevron.down")
                }
            }
        }
        .font(.subheadline)
    }
}

#Preview {
    MushroomTypePickerView(selectedMushroomName: .constant(""), mushroomNames: [])
}
