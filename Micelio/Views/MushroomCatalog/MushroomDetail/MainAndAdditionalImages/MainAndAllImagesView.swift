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
    
    var body: some View {
        ZStack {
            MainImageView(image: $selectedImage)
            GeometryReader { proxy in
                AllImagesContainerView(images: images, proxyWidth: proxy.size.width, selectedImage: $selectedImage)
            }
        }
    }
}

#Preview {
    MainAndAllImagesView(images: mushroomMockData[0].images, selectedImage: mushroomMockData[0].images[0])
}
