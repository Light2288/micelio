//
//  MainTabView.swift
//  Micelio
//
//  Created by Davide Aliti on 05/12/24.
//

import SwiftUI

enum TabConstants {
    static let map = "Mappa"
    static let identify = "Identifica"
    static let catalog = "Catalogo"
    static let calendario = "MiCalendario"
}

struct MainTabView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        TabView {
            MushroomMapView()
                .tabItem {
                    Label(TabConstants.map, image: "mushroom-map")
                }
            
            RecogniseView()
                .tabItem {
                    Label(TabConstants.identify, image: "mushroom-identify")
                }
            
            MushroomCatalogView()
                .tabItem {
                    Label(TabConstants.catalog, image: "catalog")
                }
            MiCalendarView()
                .tabItem {
                    Label(TabConstants.calendario, image: "mushroom-calendar")
                }
        }
    }
}

