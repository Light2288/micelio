//
//  SplashScreenMushroomIconsView.swift
//  Micelio
//
//  Created by Davide Aliti on 09/07/24.
//

import SwiftUI

struct SplashScreenMushroomIconsView: View {
    let proxy: GeometryProxy
    
    let splashScreenMushrooms : [UIImage] =
    [
        UIImage(named: "splashscreen_mushroom_0")!,
        UIImage(named: "splashscreen_mushroom_1")!,
        UIImage(named: "splashscreen_mushroom_2")!,
        UIImage(named: "splashscreen_mushroom_3")!
    ]
        .shuffled()
    
    let mushroomOffsets: (GeometryProxy) -> [CGSize] = {
        return [
            CGSizeMake($0.size.width/10,  $0.size.height/2.5),
            CGSizeMake($0.size.width*9/10 - $0.size.width/5,  $0.size.height/2.5),
            CGSizeMake($0.size.width*9/10 - $0.size.width/5,  $0.size.height*19/20 - $0.size.width/5),
            CGSizeMake($0.size.width/10, $0.size.height*19/20 - $0.size.width/5),
            CGSizeZero
        ]
    }
    
    let showMushroomIconDelay: (Int) -> UInt64 = {
        return Constants.SplashScreen.MushroomIcons.showMushroomIconsTaskDelay * UInt64($0 + 1)
    }

    var body: some View {
        ForEach(0 ..< 4) { id in
            SplashScreenMushroomIconView(image: splashScreenMushrooms[id], width: proxy.size.width/5, height: proxy.size.width/5, offset: mushroomOffsets(proxy)[id], showMushroomIconDelay: showMushroomIconDelay(id), hideMushroomIconDelay: Constants.SplashScreen.MushroomIcons.showMushroomIconsTaskDelay)
        }
    }
}

#Preview {
    GeometryReader { geometry in
        SplashScreenMushroomIconsView(proxy: geometry)
    }
}
