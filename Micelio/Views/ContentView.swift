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

#Preview {
    ContentView()
}
