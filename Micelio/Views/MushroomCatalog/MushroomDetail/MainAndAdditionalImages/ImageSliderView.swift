//
//  ImageSliderView.swift
//  Micelio
//
//  Created by Davide Aliti on 04/06/24.
//

import SwiftUI

struct ImageSliderView: View {
    let images: [String]
    @Binding var selectedImage: String
    let width: CGFloat
    
    var body: some View {
        TabView(selection: $selectedImage) {
            ForEach(images, id: \.self) { image in
                PhotoThumbnailView(imageUrl: Bundle.main.url(forResource: image, withExtension: "jpeg") ?? URL(filePath: ""), width: width, height: width)
            }
        }
        .frame(height: width)
        .tabViewStyle(PageTabViewStyle())
    }
}

#Preview {
    GeometryReader { proxy in
        ImageSliderView(images: mushroomData[0].images, selectedImage: .constant(mushroomData[0].images[0]), width: proxy.size.width)
    }
}
