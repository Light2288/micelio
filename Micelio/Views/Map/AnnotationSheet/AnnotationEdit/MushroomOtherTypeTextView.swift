//
//  MushroomOtherTypeTextView.swift
//  Micelio
//
//  Created by Davide Aliti on 10/03/24.
//

import SwiftUI

struct MushroomOtherTypeTextView: View {
    
    @Binding var otherMushroomNameText: String
    
    var body: some View {
        TextField("Inserisci manualmente la tipologia di fungo", text: $otherMushroomNameText)
            .textFieldStyle(.roundedBorder)
            .font(.subheadline)
    }
}

#Preview {
    MushroomOtherTypeTextView(otherMushroomNameText: .constant(""))
}
