//
//  MainAndAdditionalImagesView.swift
//  Micelio
//
//  Created by Davide Aliti on 27/11/23.
//

import SwiftUI

struct MainAndAdditionalImagesView: View {
    let images: [String]
    
    var body: some View {
        ZStack {
            MainImageView(image: images[0])
            AdditionalImagesContainerView(additionalImages: images)
        }
    }
}

#Preview {
    MainAndAdditionalImagesView(images: mushroomMockData[0].additionalImages)
}
