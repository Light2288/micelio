//
//  SplashScreenBackgroundView.swift
//  Micelio
//
//  Created by Davide Aliti on 09/07/24.
//

import SwiftUI

struct SplashScreenBackgroundView: View {
    let proxy: GeometryProxy
    
    var body: some View {
        Image("splashscreen_background")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: proxy.size.width)
            .ignoresSafeArea()
    }
}

#Preview {
    GeometryReader(content: { geometry in
        SplashScreenBackgroundView(proxy: geometry)
    })
}
