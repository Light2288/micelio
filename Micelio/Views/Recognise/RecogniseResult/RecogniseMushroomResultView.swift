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
        ScrollView {
            HStack {
                Spacer()
                VStack(content: {
                    Image(uiImage: image)
                        .recogniseImageStyle()
                        .frame(maxHeight: Constants.Recognise.Results.imageFrameMaxHeight)
                    ResultsListView(recognisedMushrooms: classifier.recognisedMushrooms)
                    RecogniseDisclaimerView()
                    
                })
                .frame(maxWidth: Constants.Recognise.Results.vStackFrameMaxHeight)
                .onAppear {
                    classifier.recogniseMushroom(uiImage: image)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    RecogniseMushroomResultView(image: UIImage(imageLiteralResourceName: "porcino_0.jpeg"))
}
