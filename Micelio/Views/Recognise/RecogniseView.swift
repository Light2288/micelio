//
//  RecogniseView.swift
//  Micelio
//
//  Created by Davide Aliti on 14/12/23.
//

import SwiftUI

struct RecogniseView: View {
    @State var image: UIImage?
    @State var isSheetVisible: Bool = false
    
    @ObservedObject var classifier = MushroomClassifier()
    
    var body: some View {
        VStack {
            ImageRecogniseContainerView(image: $image)
            ForEach(classifier.recognisedMushrooms) { recognisedMushroom in
                HStack {
                    Text(recognisedMushroom.mushroomIdentifier)
                    Text(recognisedMushroom.confidencePercentage)
                }
            }
            ButtonsHStackView(image: $image, isSheetVisible: $isSheetVisible, detectMushroom: classifier.detectMushroom)
        }
        .sheet(isPresented: $isSheetVisible, content: {
            CameraView(selectedImage: $image, isSheetVisible: $isSheetVisible)
                .background(.black)
        })
    }
}

#Preview {
    RecogniseView()
}


