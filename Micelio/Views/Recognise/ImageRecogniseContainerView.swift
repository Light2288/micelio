//
//  ImageRecogniseContainerView.swift
//  Micelio
//
//  Created by Davide Aliti on 15/12/23.
//

import SwiftUI

struct ImageRecogniseContainerView: View {
    @Binding var image: UIImage?
    
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .recogniseImageStyle()
            
        } else {
            Text("Scatta una foto o seleziona un'immagine per procedere con il riconoscimento")
                .multilineTextAlignment(.center)
                .font(.title2)
                .padding()
            RecogniseDisclaimerView()
                .padding()
            Spacer()
            
        }
    }
}

#Preview {
    ImageRecogniseContainerView(image: .constant(nil))
}
