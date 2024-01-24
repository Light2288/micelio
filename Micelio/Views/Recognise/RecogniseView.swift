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
    
    var body: some View {
        NavigationStack {
            VStack {
                ImageRecogniseContainerView(image: $image)
                if let image = image {
                    VStack(content: {
                        RecogniseButtonView(image: image)
                        Spacer()
                        ChooseAnotherPhotoTextView()
                    })
                }
                Spacer()
                AddPhotoButtonsHStackView(image: $image, isSheetVisible: $isSheetVisible)
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
