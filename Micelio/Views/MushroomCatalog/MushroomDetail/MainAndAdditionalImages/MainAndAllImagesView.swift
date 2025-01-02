//
//  MainAndAllImagesView.swift
//  Micelio
//
//  Created by Davide Aliti on 27/11/23.
//

import SwiftUI

struct MainAndAllImagesView: View {
    let imageURLs: [URL]
    @State var selectedImageURL: URL
    let width: CGFloat
    
    var body: some View {
        ZStack {
            ImageSliderView(imageURLs: imageURLs, selectedImage: $selectedImageURL, width: width)
            AllImagesContainerView(imageURLs: imageURLs, proxyWidth: width, selectedImageURL: $selectedImageURL)
        }
    }
}

#Preview {
    GeometryReader { proxy in
        MainAndAllImagesView(imageURLs: mushroomData[0].imageURLs, selectedImageURL: mushroomData[0].imageURLs[0], width: proxy.size.width)
    }
}
