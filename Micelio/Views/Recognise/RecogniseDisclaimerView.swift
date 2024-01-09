//
//  RecogniseDisclaimerView.swift
//  Micelio
//
//  Created by Davide Aliti on 05/01/24.
//

import SwiftUI

struct RecogniseDisclaimerView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundStyle(.orange)
                Spacer()
                Text("Attenzione!")
                Spacer()
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundStyle(.orange)
                Spacer()
            }
            .font(.body)
            .fontWeight(.bold)
            .padding(.bottom, 3)
            Text("Fai attenzione quando usi questa funzione! Il riconoscimento automatico non è infallibile, e non tutte le specie di funghi sono identificate dalla app; alcuni funghi commestibili sono molto simili a funghi tossici, e l'app potrebbe confonderli.\n\("Non mangiare mai un fungo senza averlo fatto riconoscere da un esperto per essere certo che sia commestibile!".uppercased())")
                .font(.footnote)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(
            RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                .stroke(.orange, lineWidth: 1.5)
        )
    }
}

#Preview {
    RecogniseDisclaimerView()
}
