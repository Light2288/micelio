//
//  MainAndAllImagesView.swift
//  Micelio
//
//  Created by Davide Aliti on 27/11/23.
//

import SwiftUI

struct MainAndAllImagesView: View {
    let images: [String]
    
    var body: some View {
        ZStack {
            MainImageView(image: images[0])
            GeometryReader { proxy in
                AllImagesContainerView(images: images, proxyWidth: proxy.size.width)
            }
        }
    }
}

#Preview {
    MainAndAllImagesView(images: mushroomMockData[0].images)
}
