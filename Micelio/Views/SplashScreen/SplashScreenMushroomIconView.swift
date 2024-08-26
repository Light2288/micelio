//
//  SplashScreenMushroomIconView.swift
//  Micelio
//
//  Created by Davide Aliti on 09/07/24.
//

import SwiftUI

struct SplashScreenMushroomIconView: View {
    let image: UIImage
    let width: CGFloat
    let height: CGFloat
    let offset: CGSize
    let showMushroomIconDelay: UInt64
    let hideMushroomIconDelay: UInt64
    
    @State private var mushroomIconOpacity: CGFloat = 0
    
    @MainActor func showHideMushroomIcon() async {
        try? await Task.sleep(nanoseconds: showMushroomIconDelay)
        withAnimation() {
            mushroomIconOpacity = 1
        }
        
        try? await Task.sleep(nanoseconds: hideMushroomIconDelay)
        withAnimation() {
            mushroomIconOpacity = 0
        }
    }
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
            .offset(offset)
            .opacity(mushroomIconOpacity)
            .task {
                await showHideMushroomIcon()
            }
    }
}

#Preview {
    SplashScreenMushroomIconView(image: UIImage(named: "splashscreen_mushroom_0")!, width: 50, height: 50, offset: CGSizeZero, showMushroomIconDelay: Constants.SplashScreen.MushroomIcons.showMushroomIconsTaskDelay, hideMushroomIconDelay: Constants.SplashScreen.MushroomIcons.showMushroomIconsTaskDelay)
}
