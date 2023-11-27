//
//  ContentView.swift
//  Micelio
//
//  Created by Davide Aliti on 02/10/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View {
        TabView {
            Text("Tab 1")
                .tabItem {
                    Label("Map", image: "mushroom-map")
                }
            
            Text("Tab 2")
                .tabItem {
                    Label("Identify", image: "mushroom-identify")
                }
            
            MushroomCatalogView()
                .tabItem {
                    Label("Catalog", image: "catalog")
                }
//                .toolbarBackground(Color("CustomSecondaryColor"), for: .tabBar)
//                .toolbarBackground(.visible, for: .tabBar)
        }
    }
}

#Preview {
    ContentView()
}
