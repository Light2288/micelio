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
    @State private var navigateToResultPage: Bool = false
    
    @ObservedObject var classifier = MushroomClassifier()
    @ObservedObject var mushroomDetector = MushroomDetector()
    
    var body: some View {
        NavigationStack {
            VStack {
                ImageRecogniseContainerView(image: $image)
                if let image = image {
                    VStack(content: {
                        if !mushroomDetector.mushroomDetected {
                            MushroomNotDetectedTextView()
                        }
                        RecogniseButtonView(image: image)
                        Spacer()
                        ChooseAnotherPhotoTextView()
                    })
                }
                Spacer()
                AddPhotoButtonsHStackView(image: $image, isSheetVisible: $isSheetVisible)
            }
            .onChange(of: image) { newValue in
                if let image = image {
                    mushroomDetector.detectMushroom(uiImage: image)
                }
            }
            .frame(maxWidth: Constants.Recognise.maxWidth)
            .sheet(isPresented: $isSheetVisible, content: {
                CameraView(selectedImage: $image, isSheetVisible: $isSheetVisible)
                    .background(.black)
            })
        }
    }
}

#Preview {
    RecogniseView()
}
