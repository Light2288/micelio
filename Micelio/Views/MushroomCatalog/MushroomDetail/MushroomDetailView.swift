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
                
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20, content: {
                    ZStack(alignment: .bottom) {
                        MainAndAdditionalImagesView(images: mushroom.additionalImages)
                        TitleAndDetailsView(mushroom: mushroom, offset: proxy.size.width - 70)
                    }
                    
                    VStack(alignment: .leading, spacing: 25, content: {
                        Spacer(minLength: proxy.size.width - 60)
                        
                        ShortDescriptionView(text: mushroom.shortDescription)
                        
                        MushroomDetailSectionView(title: "Descrizione", content: mushroom.description)
                        
                        MushroomDetailSectionView(title: "Commestibilità", content: mushroom.environmentDescription)
                        
                        MushroomDetailSectionView(title: "Habitat", content: mushroom.environmentDescription)
                        
                        MushroomDetailSectionView(title: "Curiosità", content: mushroom.trivia)
                    })
                    .padding(.horizontal, 20)
                    .padding(.bottom, 50)
                    .frame(maxWidth: 640, alignment: .center)
                    
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
        MushroomDetailView(mushroom: mushroomMockData[0])
    })
    
}
