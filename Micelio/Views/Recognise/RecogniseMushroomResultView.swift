//
//  RecogniseMushroomResultView.swift
//  Micelio
//
//  Created by Davide Aliti on 02/01/24.
//

import SwiftUI

struct RecogniseMushroomResultView: View {
    var image: UIImage
    @ObservedObject var classifier = MushroomClassifier()
    
    var body: some View {
        VStack(content: {
            Image(uiImage: image)
                .recogniseImageStyle()
            ForEach(classifier.recognisedMushrooms) { recognisedMushroom in
                HStack {
                    Text(recognisedMushroom.mushroomIdentifier)
                    Text(recognisedMushroom.confidencePercentage)
                }
            }
        })
        .task {
            classifier.detectMushroom(uiImage: image)
        }
    }
}

#Preview {
    RecogniseMushroomResultView(image: UIImage(imageLiteralResourceName: "porcino_0.jpeg"))
}
