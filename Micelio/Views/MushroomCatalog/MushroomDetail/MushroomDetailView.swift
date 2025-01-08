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
    
    private let externalVStackSpacing = Constants.MushroomCatalog.MushroomDetail.externalVStackSpacing
    private let internalVStackSpacing = Constants.MushroomCatalog.MushroomDetail.internalVStackSpacing
    private let horizontalPadding = Constants.MushroomCatalog.MushroomDetail.internalVStackHorizontalPadding
    private let bottomPadding = Constants.MushroomCatalog.MushroomDetail.internalVStackBottomPadding
    private let maxInternalWidth = Constants.MushroomCatalog.MushroomDetail.internalVStackFrameMaxWidth
    private let offsetCorrectionRatio = Constants.MushroomCatalog.MushroomDetail.titleAndDetailsOffsetCorrectionRatio
    private let spacerCorrectionRatio = Constants.MushroomCatalog.MushroomDetail.spacerMinLengthCorrectionRatio
    
    var detailSections: [DetailSection] {
        mushroom.detailSections()
    }
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.vertical) {
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: externalVStackSpacing, content: {
                    ZStack() {
                        MainAndAllImagesView(imageURLs: mushroom.imageURLs, selectedImageURL: mushroom.imageURLs[0], width: proxy.size.width)
                        TitleAndDetailsView(mushroom: mushroom, offset: proxy.size.width / offsetCorrectionRatio, width: proxy.size.width)
                    }
                    
                    VStack(alignment: .leading, spacing: internalVStackSpacing, content: {
                        Spacer(minLength: proxy.size.width / spacerCorrectionRatio)
                        
                        ShortDescriptionView(text: mushroom.shortDescription)
                        
                        ForEach(detailSections) { section in
                            MushroomDetailSectionView(
                                title: section.title,
                                content: section.content,
                                image: section.image
                            )
                        }
                    })
                    .padding(.horizontal, horizontalPadding)
                    .padding(.bottom, bottomPadding)
                    .frame(maxWidth: maxInternalWidth, alignment: .center)
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
