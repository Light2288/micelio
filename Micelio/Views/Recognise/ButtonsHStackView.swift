//
//  ButtonsHStackView.swift
//  Micelio
//
//  Created by Davide Aliti on 15/12/23.
//

import SwiftUI
import PhotosUI

struct ButtonsHStackView: View {
    @Binding var image: UIImage?
    @Binding var isSheetVisible: Bool
    @State private var selectedItem: PhotosPickerItem? = nil
    let detectMushroom: (UIImage) -> Void
    
    var body: some View {
        HStack(content: {
            Button(action: {
                isSheetVisible.toggle()
            }, label: {
                Image("recognise-camera")
                    .resizableImageWithShapeBackground(shape: AnyShape(Circle()), frameWidth: Constants.Recognise.ButtonHStack.roundButtonSize, frameHeight: Constants.Recognise.ButtonHStack.roundButtonSize)
            })
            
            Button(action: {
                if let image = image {
                    detectMushroom(image)
                }
            }, label: {
                Text("Riconosci fungo")
                    .viewWithShapeBackground(shape: AnyShape(Capsule()), width: Constants.Recognise.ButtonHStack.capsuleButtonWidth, height: Constants.Recognise.ButtonHStack.roundButtonSize)
            })
            .disabled(image == nil)
            
            PhotosPicker(selection: $selectedItem, matching: .images) {
                Image("recognise-gallery")
                    .resizableImageWithShapeBackground(shape: AnyShape(Circle()), frameWidth: Constants.Recognise.ButtonHStack.roundButtonSize, frameHeight: Constants.Recognise.ButtonHStack.roundButtonSize)
            }
            .onChange(of: selectedItem, perform: { value in
                Task {
                    if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                        image = UIImage(data: data)
                    }
                }
            })
            
        })
        .padding(.bottom, 20)
    }
}

#Preview {
    ButtonsHStackView(image: .constant(nil), isSheetVisible: .constant(false), detectMushroom: {_ in })
}
