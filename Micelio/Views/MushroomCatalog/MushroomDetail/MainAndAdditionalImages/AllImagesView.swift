//
//  AllImagesView.swift
//  Micelio
//
//  Created by Davide Aliti on 17/11/23.
//

import SwiftUI

struct AllImagesView: View {
    let images: [String]
    let width: CGFloat
    let height: CGFloat
    
    var columns: Array<GridItem> {
        Array(
            repeating: GridItem(
                .flexible()
            ),
            count: 1
        )
    }
    
    @State var isExpanded: Bool = true
    
    var body: some View {
        LazyVGrid(
            columns: columns,
            spacing: Constants.MushroomCatalog.MushroomDetail.MainAndAdditionalImage.AllImages.rowSpacing
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
    }
}

#Preview {
    return AllImagesView(images: mushroomMockData[0].images, width: 100, height: 100)
}
