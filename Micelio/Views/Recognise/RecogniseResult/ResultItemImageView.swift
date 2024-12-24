//
//  ResultItemImageView.swift
//  Micelio
//
//  Created by Davide Aliti on 23/01/24.
//

import SwiftUI

struct ResultItemImageView: View {
    let recognisedMushroom: RecognisedMushroom
    
    private let overlayCornerRadius: CGFloat = Constants.Recognise.Results.ResultList.ResultItem.overlayCornerRadius

    
    var body: some View {
        GeometryReader { proxy in
            let imageUrl = Bundle.main.url(forResource: recognisedMushroom.mushroomDetail.images[0], withExtension: "jpeg") ?? URL(filePath: "")
            
            PhotoThumbnailView(imageUrl: imageUrl, width: proxy.size.height, height: proxy.size.height)
                .clipShape(
                    .rect(
                        topLeadingRadius: overlayCornerRadius,
                        bottomLeadingRadius: overlayCornerRadius,
                        bottomTrailingRadius: .zero,
                        topTrailingRadius: .zero
                    )
                )
        }
        .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    ResultItemImageView(
        recognisedMushroom: RecognisedMushroom(mushroomIdentifier: "Boletus Edulis", confidence: 0.98569)
    )
}
