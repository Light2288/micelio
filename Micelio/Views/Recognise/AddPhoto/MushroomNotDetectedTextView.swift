//
//  MushroomNotDetectedTextView.swift
//  Micelio
//
//  Created by Davide Aliti on 28/01/24.
//

import SwiftUI

struct MushroomNotDetectedTextView: View {
    var body: some View {
        Text("Sembra che la foto scelta non contenga funghi.\nPuoi procedere lo stesso con il riconoscimento, ma i risultati potrebbero essere poco attendibili.")
            .font(.caption2)
            .multilineTextAlignment(.center)
            .padding()
    }
}

#Preview {
    MushroomNotDetectedTextView()
}
