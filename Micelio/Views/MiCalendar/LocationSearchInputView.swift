//
//  LocationSearchInputView.swift
//  Micelio
//
//  Created by Davide Aliti on 19/06/25.
//

import SwiftUI
import MapKit

struct LocationSearchInputView: View {
    @State private var debounceWorkItem: DispatchWorkItem? = nil
    @Environment(\.dismiss) private var dismiss
    
    @Binding var query: String
    @Binding var searchCompleter: MKLocalSearchCompleter
    @EnvironmentObject private var miCalendarLocationManager: MiCalendarLocationManager
        
    var body: some View {
        HStack {
            TextField("Cerca città", text: $query)
                .textFieldStyle(.roundedBorder)
                .padding(.leading)
                .onChange(of: query) { newValue in
                    guard newValue.count >= Constants.MiCalendar.LocationSearchInput.minCharacterCount else { return }
                    debounceWorkItem?.cancel()
                    
                    let workItem = DispatchWorkItem {
                        searchCompleter.queryFragment = newValue
                    }
                    
                    debounceWorkItem = workItem
                    DispatchQueue.main.asyncAfter(
                        deadline: .now() + Constants.MiCalendar.LocationSearchInput.dispatchQueueDelay,
                        execute: workItem
                    )
                }
            Button {
                Task {
                    if let cityLocation = await miCalendarLocationManager.resolveUserCityLocation() {
                        miCalendarLocationManager.setSelectedLocation(cityLocation)
                        dismiss()
                    }
                }
            } label: {
                Image(systemName: "location.fill")
            }
            .padding(.trailing)
            .accessibilityLabel("Usa la posizione attuale")
        }
    }
}

#Preview {
    LocationSearchInputView(query: .constant("Mil"), searchCompleter: .constant(MKLocalSearchCompleter()))
}
