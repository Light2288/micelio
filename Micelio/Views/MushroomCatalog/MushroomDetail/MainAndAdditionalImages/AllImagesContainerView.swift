//
//  AllImagesContainerView.swift
//  Micelio
//
//  Created by Davide Aliti on 27/11/23.
//

import SwiftUI

struct AllImagesContainerView: View {
    let imageURLs: [URL]
    let proxyWidth: CGFloat
    
    @Binding var selectedImageURL: URL
    
    let smallImageSizeCorrectionFactor = Constants.MushroomCatalog.MushroomDetail.MainAndAdditionalImage.AllImagesContainer.smallImageSizeCorrectionFactor
    let backgroundRectangleWidthCorrectionFactor = Constants.MushroomCatalog.MushroomDetail.MainAndAdditionalImage.AllImagesContainer.backgroundRectangleWidthCorrectionFactor
    let backgroundRectangleHeightCorrection = Constants.MushroomCatalog.MushroomDetail.MainAndAdditionalImage.AllImagesContainer.backgroundRectangleHeightCorrection
    let backgroundRectangleShadowRadius = Constants.MushroomCatalog.MushroomDetail.MainAndAdditionalImage.AllImagesContainer.backgroundRectangleShadowRadius
    let backgroundRectangleShadowX = Constants.MushroomCatalog.MushroomDetail.MainAndAdditionalImage.AllImagesContainer.backgroundRectangleShadowX
    
    var smallImageSize: CGFloat {
        proxyWidth/CGFloat(imageURLs.count + smallImageSizeCorrectionFactor)
    }
    
    var smallImageArrayHeight: CGFloat {
        smallImageSize*CGFloat(imageURLs.count)
    }
    
    private var rectangleBackgroundDimensions: CGSize {
        CGSize(
            width: proxyWidth / CGFloat(imageURLs.count + backgroundRectangleWidthCorrectionFactor),
            height: smallImageArrayHeight + backgroundRectangleHeightCorrection
        )
    }
    
    var body: some View {
        HStack {
            Spacer(minLength: proxyWidth - rectangleBackgroundDimensions.width)
            VStack() {
                AllImagesView(
                    imageURLS: imageURLs,
                    thumbnailSize: CGSize(width: smallImageSize, height: smallImageSize),
                    selectedImageURL: $selectedImageURL
                )
                .background {
                    Rectangle()
                        .frame(
                            width: rectangleBackgroundDimensions.width,
                            height: rectangleBackgroundDimensions.height
                        )
                        .foregroundStyle(.ultraThinMaterial)
                        .shadow(
                            color: .black,
                            radius: backgroundRectangleShadowRadius,
                            x: backgroundRectangleShadowX)
                }
            }
            
        }
        
    }
}

#Preview {
    GeometryReader { proxy in
        AllImagesContainerView(imageURLs: mushroomData[0].imageURLs, proxyWidth: proxy.size.width, selectedImageURL: .constant(mushroomData[0].imageURLs[0]))
    }
}
