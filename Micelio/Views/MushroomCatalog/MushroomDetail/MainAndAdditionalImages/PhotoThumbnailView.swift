//
//  PhotoThumbnail.swift
//  Micelio
//
//  Created by Davide Aliti on 15/11/23.
//

import SwiftUI

struct PhotoThumbnailView: View {
    let imageUrl: URL
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        AsyncImage(url: imageUrl) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(
                    width: width,
                    height: height
                )
                .clipped()
        } placeholder: {
            ProgressView()
                .frame(width: width, height: height)
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    let url = Bundle.main.url(forResource: "0", withExtension: "jpeg")
    
    return PhotoThumbnailView(imageUrl: url!, width: 100, height: 100)
}
