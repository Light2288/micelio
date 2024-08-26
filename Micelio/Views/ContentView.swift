//
//  ContentView.swift
//  Micelio
//
//  Created by Davide Aliti on 02/10/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var showSplashScreen: Bool = true
    
    @MainActor func hideSplashScreen() async {
        Task(priority: .background) {
            try? await Task.sleep(nanoseconds: Constants.SplashScreen.hideSplashScreenDelay)
            withAnimation {
                showSplashScreen.toggle()
            }
        }
    }
    
    var body: some View {
        if showSplashScreen {
            SplashScreenView()
                .task {
                    await hideSplashScreen()
                }
        } else {
            TabView {
                MushroomMapView()
                    .tabItem {
                        Label("Map", image: "mushroom-map")
                    }
                
                RecogniseView()
                    .tabItem {
                        Label("Identify", image: "mushroom-identify")
                    }
                
                MushroomCatalogView()
                    .tabItem {
                        Label("Catalog", image: "catalog")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
