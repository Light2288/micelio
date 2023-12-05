//
//  MainImageView.swift
//  Micelio
//
//  Created by Davide Aliti on 27/11/23.
//

import SwiftUI

struct MainImageView: View {
    @Binding var image: String
    
    var body: some View {
        GeometryReader { proxy in
            PhotoThumbnailView(imageUrl: Bundle.main.url(forResource: image, withExtension: "jpeg")!, width: proxy.size.width, height: proxy.size.width)
        }
    }
}

#Preview {
    MainImageView(image: .constant(mushroomMockData[0].images[0]))
}
