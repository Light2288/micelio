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
        NavigationStack {
            VStack {
                ImageRecogniseContainerView(image: $image)
                if (image != nil) {
                    VStack(content: {
                        NavigationLink(destination: RecogniseMushroomResultView(image: image!)) {
                            Text("Riconosci fungo")
                                .viewWithShapeBackground(shape: AnyShape(Capsule()), width: Constants.Recognise.ButtonHStack.capsuleButtonWidth, height: Constants.Recognise.ButtonHStack.roundButtonSize)
                        }
                        Spacer()
                        Text("oppure scegli un'altra fotografia:")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding()
                    })
                }
                AddPhotoButtonsHStackView(image: $image, isSheetVisible: $isSheetVisible)
            }
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


