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

struct MushroomDetail: View {
    let mushroom: Mushroom
    @State private var initialScrollValue: CGFloat = .zero
    @State private var scrollPosition: CGPoint = .zero
    
    var body: some View {
//        NavigationView {
            ScrollView(.vertical) {
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20, content: {
                    ZStack(alignment: .bottom) {
                        MainImage()
                        TitleAndDetails(mushroom: mushroom)
                    }
                    
                    VStack(alignment: .leading, spacing: 25, content: {
                        Spacer(minLength: 50)
                                                
                        ShortDescription(text: mushroom.shortDescription)
                        
                        MushroomDetailSection(title: "Descrizione", content: mushroom.description)
                        
                        MushroomDetailSection(title: "Commestibilità", content: mushroom.environmentDescription)
                        
                        MushroomDetailSection(title: "Habitat", content: mushroom.environmentDescription)
                        
                        MushroomDetailSection(title: "Curiosità", content: mushroom.trivia)
                        
                        // Section for additional images
                        
                    })
                    .padding(.horizontal, 20)
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



#Preview {
    NavigationView(content: {
        MushroomDetail(mushroom: mushroomMockData[0])
    })
    
}
