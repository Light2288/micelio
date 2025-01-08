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
    
    let roundButtonSize = Constants.Recognise.AddPhotoButtons.roundButtonSize
    let horizontalBottomPadding = Constants.Recognise.AddPhotoButtons.horizontalBottomPadding
    
    
    var body: some View {
        HStack(content: {
            Button(action: {
                isSheetVisible.toggle()
            }, label: {
                Image("recognise-camera")
                    .resizableImageWithShapeBackground(
                        shape: AnyShape(Circle()),
                        frameWidth: roundButtonSize,
                        frameHeight: roundButtonSize
                    )
            })
            
            Spacer()
            
            PhotosPicker(selection: $selectedItem, matching: .images) {
                Image("recognise-gallery")
                    .resizableImageWithShapeBackground(
                        shape: AnyShape(Circle()),
                        frameWidth: roundButtonSize,
                        frameHeight: roundButtonSize
                    )
            }
            .onChange(of: selectedItem, perform: { newValue in
                Task {
                    if let data = try? await newValue?.loadTransferable(type: Data.self) {
                        image = UIImage(data: data)
                    }
                }
            })
            
        })
        .padding([.horizontal, .bottom], horizontalBottomPadding)
    }
}

#Preview {
    AddPhotoButtonsHStackView(image: .constant(nil), isSheetVisible: .constant(false))
}
