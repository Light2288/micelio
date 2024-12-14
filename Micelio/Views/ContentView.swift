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
    private let hideSplashScreenDelay = Constants.SplashScreen.hideSplashScreenDelay
    
    @MainActor func hideSplashScreen() async {
        Task(priority: .background) {
            try? await Task.sleep(nanoseconds: hideSplashScreenDelay)
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
            MainTabView()
        }
    }
}

#Preview {
    ContentView()
}
