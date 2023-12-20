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
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .padding()
            } else {
                Text("Scatta una foto o seleziona un'immagine per procedere con il riconoscimento")
                    .multilineTextAlignment(.center)
                    .font(.title2)
                    .padding()
            }
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ImageRecogniseContainerView(image: .constant(nil))
}
