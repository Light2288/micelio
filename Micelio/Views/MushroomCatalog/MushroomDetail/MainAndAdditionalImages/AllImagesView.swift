//
//  AllImagesView.swift
//  Micelio
//
//  Created by Davide Aliti on 17/11/23.
//

import SwiftUI

struct AllImagesView: View {
    let imageURLS: [URL]
    let thumbnailSize: CGSize
    
    @Binding var selectedImageURL: URL
    
    let rowSpacing = Constants.MushroomCatalog.MushroomDetail
        .MainAndAdditionalImage.AllImages.rowSpacing
    
    var body: some View {
        LazyVGrid(
            columns: [GridItem(.flexible())],
            spacing: rowSpacing
        ) {
            ForEach(imageURLS, id: \.self) { imageURL in
                ThumbnailImageButtonView(
                    imageUrl: imageURL, thumbnailSize: thumbnailSize,
                    isSelected: imageURL == selectedImageURL
                ) {
                    selectedImageURL = imageURL
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        AllImagesView(
            imageURLS: mushroomData[0].imageURLs, thumbnailSize: CGSize(width: 100, height: 100),
            selectedImageURL: .constant(mushroomData[0].imageURLs[0]))
    }
}
