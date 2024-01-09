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
    @State var showWarningAlert: Bool = false
    @State private var navigateToResultPage: Bool = false
    
    @ObservedObject var classifier = MushroomClassifier()
    
    var body: some View {
        NavigationStack {
            VStack {
                ImageRecogniseContainerView(image: $image)
                if let image = image {
                    VStack(content: {
                        RecogniseButtonView(showWarningAlert: $showWarningAlert)
                        Spacer()
                        ChooseAnotherPhotoTextView()
                    })
                    .navigationDestination(isPresented: $navigateToResultPage) {
                        RecogniseMushroomResultView(image: image)
                    }
                }
                
                AddPhotoButtonsHStackView(image: $image, isSheetVisible: $isSheetVisible)
            }
            .alert("Attenzione!", isPresented: $showWarningAlert) {
                Button("Prosegui") {
                    DispatchQueue.main.async {
                        self.navigateToResultPage = true
                    }
                }
                Button("Annulla", role: .cancel) { }
            } message: {
                Text("L'app proverà a riconoscere la specie del fungo dalla foto. Fai attenzione! Il riconoscimento automatico non è infallibile, e non tutte le specie di funghi sono identificate dalla app; alcuni funghi commestibili sono molto simili a funghi tossici, e l'app potrebbe confonderli.\n\("Non mangiare mai un fungo senza averlo fatto riconoscere da un esperto per essere certo che sia commestibile!".uppercased())")
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
