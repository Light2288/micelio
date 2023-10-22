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
                    // Image view
                    Color("CustomSecondaryColor")
                        .frame(height: 440)
                    
                    VStack(alignment: .leading, spacing: 20, content: {
                        
                        Text(mushroom.name)
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundStyle(Color(.accent))
                        
                        // Season, edibility, environment view
                        
                        Text(mushroom.shortDescription)
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                        
                        // Section for long description
                        DisclosureGroup("Description") {
                            Text(mushroom.description)
                        }
                        
                        // Section for environment description
                        
                        // Section for edibility description
                        
                        // Section for trivia
                        
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
        MushroomDetail(mushroom: mushroomData[0])
    })
    
}
