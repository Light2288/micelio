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
    
    var body: some View {
        VStack {
            ImageRecogniseContainerView(image: $image)
            ButtonsHStackView(image: $image, isSheetVisible: $isSheetVisible)
        }
        .sheet(isPresented: $isSheetVisible, content: {
            CameraView()
        })
    }
}

#Preview {
    RecogniseView()
}


