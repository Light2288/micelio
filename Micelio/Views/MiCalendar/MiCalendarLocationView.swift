//
//  MiCalendarLocationView.swift
//  Micelio
//
//  Created by Davide Aliti on 19/06/25.
//

import SwiftUI

struct MiCalendarLocationView: View {
    @ObservedObject private var miCalendarLocationManager = MiCalendarLocationManager.shared
    var currentCityName: String
    @Binding var showLocationSheet: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            Button {
                if let location = miCalendarLocationManager.selectedLocation {
                    if miCalendarLocationManager.isFavorite(location) {
                        miCalendarLocationManager.removeFromFavorites(location)
                    } else {
                        miCalendarLocationManager.addToFavorites(location)
                    }
                }
            } label: {
                Image(systemName: miCalendarLocationManager.selectedLocation.flatMap { miCalendarLocationManager.isFavorite($0) } == true ? "star.fill" : "star")
                    .foregroundColor(Color("CustomSecondaryColor"))
                    .font(.title3)
            }
            
            Text(currentCityName)
                .font(.title2)
                .bold()
            
            Button {
                showLocationSheet = true
            } label: {
                Image(systemName: "magnifyingglass.circle.fill")
                    .font(.title2)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    MiCalendarLocationView(currentCityName: "Milano", showLocationSheet: .constant(true))
}
