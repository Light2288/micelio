//
//  AdditionalImagesView.swift
//  Micelio
//
//  Created by Davide Aliti on 17/11/23.
//

import SwiftUI

struct AdditionalImagesView: View {
    let images: [String]
    let width: CGFloat
    let height: CGFloat
    
    var columns: Array<GridItem> {
        Array(
            repeating: GridItem(
                .flexible(),
                spacing: 1
            ),
            count: 1
        )
    }
    
    @State var isExpanded: Bool = true
    
    var body: some View {
        LazyVGrid(
            columns: columns,
            spacing: 1
        ) {
            ForEach(images, id: \.self) { image in
                Button {
                    
                } label: {
                    PhotoThumbnailView(
                        imageUrl: Bundle.main.url(forResource: image, withExtension: "jpeg")!,
                        width: width, height: height
                    )
                }
            }
        }
//        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 20, x: -10, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    return AdditionalImagesView(images: mushroomMockData[0].additionalImages, width: 100, height: 100)
}
