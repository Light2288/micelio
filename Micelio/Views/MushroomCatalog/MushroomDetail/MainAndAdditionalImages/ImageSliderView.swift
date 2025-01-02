//
//  ImageSliderView.swift
//  Micelio
//
//  Created by Davide Aliti on 04/06/24.
//

import SwiftUI

struct ImageSliderView: View {
    let imageURLs: [URL]
    @Binding var selectedImage: URL
    let width: CGFloat
    
    var body: some View {
        TabView(selection: $selectedImage) {
            ForEach(imageURLs, id: \.self) { imageURL in
                PhotoThumbnailView(
                    imageUrl: imageURL,
                    width: width,
                    height: width
                )
            }
        }
        .frame(height: width)
        .tabViewStyle(PageTabViewStyle())
    }
}

#Preview {
    GeometryReader { proxy in
        ImageSliderView(imageURLs: mushroomData[0].imageURLs, selectedImage: .constant(mushroomData[0].imageURLs[0]), width: proxy.size.width)
    }
}
