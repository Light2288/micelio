//
//  ThumbnailImageButtonView.swift
//  Micelio
//
//  Created by Davide Aliti on 02/01/25.
//

import SwiftUI

struct ThumbnailImageButtonView: View {
    let imageUrl: URL
    let thumbnailSize: CGSize
    let isSelected: Bool
    let onTap: () -> Void
    
    let selectedImageBorderWidth: CGFloat = Constants.MushroomCatalog.MushroomDetail.MainAndAdditionalImage.AllImages.selectedImageBorderWidth
    
    var imageBorderColor: Color {
        isSelected ? .accent : .clear
    }
    
    var imageBorderWidth: CGFloat {
        isSelected ? selectedImageBorderWidth : 0
    }
    
    var body: some View {
        Button(action: onTap) {
            PhotoThumbnailView(
                imageUrl: imageUrl,
                width: thumbnailSize.width,
                height: thumbnailSize.height
            )
            .border(imageBorderColor, width: imageBorderWidth)
        }
    }
}

#Preview {
    ThumbnailImageButtonView(imageUrl: mushroomData[0].imageURLs[0], thumbnailSize: CGSize(width: 100, height: 100), isSelected: true, onTap: { return })
}
