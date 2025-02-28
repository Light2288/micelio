//
//  SplashScreenView.swift
//  Micelio
//
//  Created by Davide Aliti on 05/07/24.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var mainIconOpacity: CGFloat = 0
    @State private var textOpacity: CGFloat = 0
    
    let showMainIconTaskDelay = Constants.SplashScreen.showMainIconTaskDelay
    let showMainTextAnimationDuration = Constants.SplashScreen.showMainTextAnimationDuration
    let mainTextFontSize = Constants.SplashScreen.mainTextFontSize
        
    @MainActor func showMainIconAndText() async {
        try? await Task.sleep(nanoseconds: showMainIconTaskDelay)
        withAnimation() {
            mainIconOpacity = 1
        }
        
        let appearAnimation = Animation.easeInOut(duration: showMainTextAnimationDuration)
        withAnimation(appearAnimation) {
            textOpacity = 1
        }
    }
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                SplashScreenBackgroundView(proxy: proxy)
                
                SplashScreenMushroomIconsView(proxy: proxy)
                
                VStack(alignment: .center) {
                    Image("splashscreen_mushroom")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: proxy.size.width/2, height: proxy.size.width/2)
                        .offset(CGSizeMake(proxy.size.width/4,  proxy.size.height/3))
                        .opacity(mainIconOpacity)
                    Text("Micelio")
                        .font(.system(size: mainTextFontSize))
                        .fontWeight(.bold)
                        .foregroundStyle(.accent)
                        .offset(CGSizeMake(proxy.size.width/4,  proxy.size.height/3))
                        .opacity(textOpacity)
                }
                .task {
                    await showMainIconAndText()
                }
                
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
