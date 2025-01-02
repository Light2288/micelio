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
        AsyncImage(url: imageUrl) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(
                        width: width,
                        height: height
                    )
                    .clipped()
            case .failure:
                Image(systemName: "eye.slash")
                    .frame(width: width, height: height)
            case .empty:
                ProgressView()
                    .frame(width: width, height: height)
            @unknown default:
                ProgressView()
                    .frame(width: width, height: height)
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    let url = Bundle.main.url(forResource: "porcino_0", withExtension: "jpeg")
    
    return PhotoThumbnailView(imageUrl: url!, width: 100, height: 100)
}
