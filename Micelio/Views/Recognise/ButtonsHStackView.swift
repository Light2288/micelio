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
    
    var body: some View {
        HStack(content: {
            Button(action: {
                isSheetVisible.toggle()
            }, label: {
                Image("recognise-camera")
            })
            .buttonStyle(ShapeButtonStyle(shape: AnyShape(Circle())))
            
            Button(action: {
                
            }, label: {
                Text("Riconosci fungo")
            })
            .buttonStyle(ShapeButtonStyle(shape: AnyShape(Capsule())))
            .disabled(image == nil)
            
            PhotosPicker(selection: $selectedItem, matching: .images) {
                Image("recognise-gallery")
                    .imageWithShapeBackground(shape: AnyShape(Circle()))
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
    ButtonsHStackView(image: .constant(nil), isSheetVisible: .constant(false))
}
