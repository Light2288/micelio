//
//  AddPhotoButtonsHStackView.swift
//  Micelio
//
//  Created by Davide Aliti on 15/12/23.
//

import SwiftUI
import PhotosUI

struct AddPhotoButtonsHStackView: View {
    @Binding var image: UIImage?
    @Binding var isSheetVisible: Bool
    @State private var selectedItem: PhotosPickerItem? = nil
    
    var body: some View {
        HStack(content: {
            Button(action: {
                isSheetVisible.toggle()
            }, label: {
                Image("recognise-camera")
                    .resizableImageWithShapeBackground(shape: AnyShape(Circle()), frameWidth: Constants.Recognise.AddPhotoButtons.roundButtonSize, frameHeight: Constants.Recognise.AddPhotoButtons.roundButtonSize)
            })
            
            Spacer()
            
            PhotosPicker(selection: $selectedItem, matching: .images) {
                Image("recognise-gallery")
                    .resizableImageWithShapeBackground(shape: AnyShape(Circle()), frameWidth: Constants.Recognise.AddPhotoButtons.roundButtonSize, frameHeight: Constants.Recognise.AddPhotoButtons.roundButtonSize)
            }
            .onChange(of: selectedItem, perform: { value in
                Task {
                    if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                        image = UIImage(data: data)
                    }
                }
            })
            
        })
        .padding([.horizontal, .bottom], Constants.Recognise.AddPhotoButtons.horizontalBottomPadding)
    }
}

#Preview {
    AddPhotoButtonsHStackView(image: .constant(nil), isSheetVisible: .constant(false))
}
