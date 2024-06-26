//
//  MushroomDetail.swift
//  Micelio
//
//  Created by Davide Aliti on 13/10/23.
//

import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero

    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
    }
}

struct MushroomDetailView: View {
    let mushroom: Mushroom
    @State private var initialScrollValue: CGFloat = .zero
    @State private var scrollPosition: CGPoint = .zero
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.vertical) {
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: Constants.MushroomCatalog.MushroomDetail.externalVStackSpacing, content: {
                    ZStack() {
                        MainAndAllImagesView(images: mushroom.images, selectedImage: mushroom.images[0], width: proxy.size.width)
                        TitleAndDetailsView(mushroom: mushroom, offset: proxy.size.width/Constants.MushroomCatalog.MushroomDetail.titleAndDetailsOffsetCorrectionRatio, width: proxy.size.width)
                    }
                    
                    VStack(alignment: .leading, spacing: Constants.MushroomCatalog.MushroomDetail.internalVStackSpacing, content: {
                        Spacer(minLength: proxy.size.width/Constants.MushroomCatalog.MushroomDetail.spacerMinLengthCorrectionRatio)
                        
                        ShortDescriptionView(text: mushroom.shortDescription)
                        
                        MushroomDetailSectionView(title: "Descrizione", content: mushroom.description, image: "disclosuregroup-description")
                        
                        MushroomDetailSectionView(title: "Commestibilità", content: mushroom.edibilityDescription, image: "disclosuregroup-edibility")
                        
                        MushroomDetailSectionView(title: "Habitat", content: mushroom.environmentDescription, image: "disclosuregroup-habitat")
                        
                        MushroomDetailSectionView(title: "Curiosità", content: mushroom.trivia, image: "disclosuregroup-trivia")
                    })
                    .padding(.horizontal, Constants.MushroomCatalog.MushroomDetail.internalVStackHorizontalPadding)
                    .padding(.bottom, Constants.MushroomCatalog.MushroomDetail.internalVStackBottomPadding)
                    .frame(maxWidth: Constants.MushroomCatalog.MushroomDetail.internalVStackFrameMaxWidth, alignment: .center)
                })
                .background(GeometryReader { geometry in
                    Color.clear
                        .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scroll")).origin)
                })
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                    self.scrollPosition = value
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
                        self.initialScrollValue = self.scrollPosition.y
                    }
                }
            }
            .scrollIndicators(.hidden)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(scrollPosition.y > initialScrollValue - 1 ? .hidden : .visible, for: .navigationBar)
            .ignoresSafeArea(edges: .top)
            .coordinateSpace(name: "scroll")
        }
    }
}



#Preview {
    NavigationView(content: {
        MushroomDetailView(mushroom: mushroomData[0])
    })
    
}
