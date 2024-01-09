//
//  RecogniseDisclaimerBodyView.swift
//  Micelio
//
//  Created by Davide Aliti on 09/01/24.
//

import SwiftUI

struct RecogniseDisclaimerBodyView: View {
    var body: some View {
        Text("Fai attenzione quando usi questa funzione! Il riconoscimento automatico non è infallibile, e non tutte le specie di funghi sono identificate dalla app; alcuni funghi commestibili sono molto simili a funghi tossici, e l'app potrebbe confonderli.\n\("Non mangiare mai un fungo senza averlo fatto riconoscere da un esperto per essere certo che sia commestibile!".uppercased())")
            .font(.footnote)
            .multilineTextAlignment(.center)
    }
}

#Preview {
    RecogniseDisclaimerBodyView()
}
