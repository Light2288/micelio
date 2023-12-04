//
//  AllImagesContainerView.swift
//  Micelio
//
//  Created by Davide Aliti on 27/11/23.
//

import SwiftUI

struct AllImagesContainerView: View {
    let images: [String]
    let proxyWidth: CGFloat
    
    var smallImageSize: CGFloat {
        proxyWidth/CGFloat(images.count + Constants.MushroomCatalog.MushroomDetail.MainAndAdditionalImage.AllImagesContainer.smallImageSizeCorrectionFactor)
    }
    
    var smallImageArrayHeight: CGFloat {
        smallImageSize*CGFloat(images.count)
    }
    
    var allImagesRectangleBackgroundWidth: CGFloat {
        proxyWidth/CGFloat(images.count)
    }
    
    var allImagesRectangleBackgroundHeight: CGFloat {
        smallImageArrayHeight + Constants.MushroomCatalog.MushroomDetail.MainAndAdditionalImage.AllImagesContainer.backgroundRectangleHeightCorrection
    }
    
    var body: some View {
            HStack {
                Spacer(minLength: proxyWidth - allImagesRectangleBackgroundWidth)
                VStack() {
                    Spacer(minLength: (proxyWidth - allImagesRectangleBackgroundHeight)/2)
                    
                    AllImagesView(images: images, width: smallImageSize, height: smallImageSize)
                        .background {
                            Rectangle()
                                .frame(width: allImagesRectangleBackgroundWidth, height: allImagesRectangleBackgroundHeight)
                                .foregroundStyle(.ultraThinMaterial)
                                .shadow(color: .black, radius: Constants.MushroomCatalog.MushroomDetail.MainAndAdditionalImage.AllImagesContainer.backgroundRectangleShadowRadius, x: Constants.MushroomCatalog.MushroomDetail.MainAndAdditionalImage.AllImagesContainer.backgroundRectangleShadowX)
                        }
                }
                
            }
        
    }
}

#Preview {
    GeometryReader { proxy in
        AllImagesContainerView(images: mushroomMockData[0].images, proxyWidth: proxy.size.width)
    }
}
