//
//  AdditionalImagesContainerView.swift
//  Micelio
//
//  Created by Davide Aliti on 27/11/23.
//

import SwiftUI

struct AdditionalImagesContainerView: View {
    let additionalImages: [String]
    
    var body: some View {
        GeometryReader { proxy in
            HStack {
                Spacer(minLength: proxy.size.width - (proxy.size.width/CGFloat(additionalImages.count)))
                VStack() {
                    Spacer(minLength: (proxy.size.width - ((proxy.size.width/CGFloat(additionalImages.count + 3))*CGFloat(additionalImages.count)))/2)
                    
                    AdditionalImagesView( images: additionalImages, width: proxy.size.width/CGFloat(additionalImages.count + 3), height: proxy.size.width/CGFloat(additionalImages.count + 3))
                        .background {
                            Rectangle()
                                .frame(width: proxy.size.width/CGFloat(additionalImages.count), height: (proxy.size.width/CGFloat(additionalImages.count + 3))*CGFloat(additionalImages.count) + 20)
                                .foregroundStyle(.ultraThinMaterial)
                                .shadow(color: .black, radius: 20, x: -10, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                        }
                }
                
            }
        }
    }
}

#Preview {
    AdditionalImagesContainerView(additionalImages: mushroomMockData[0].additionalImages)
}
