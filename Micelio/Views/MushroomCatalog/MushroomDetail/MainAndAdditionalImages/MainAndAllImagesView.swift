//
//  MainAndAllImagesView.swift
//  Micelio
//
//  Created by Davide Aliti on 27/11/23.
//

import SwiftUI

struct MainAndAllImagesView: View {
    let images: [String]
    @State var selectedImage: String
    let width: CGFloat
    
    var body: some View {
        ZStack {
            ImageSliderView(images: images, selectedImage: $selectedImage, width: width)
                AllImagesContainerView(images: images, proxyWidth: width, selectedImage: $selectedImage)
        }
    }
}

#Preview {
    GeometryReader { proxy in
        MainAndAllImagesView(images: mushroomData[0].images, selectedImage: mushroomData[0].images[0], width: proxy.size.width)
    }
}
