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
    
    @Binding var query: String
    @Binding var searchCompleter: MKLocalSearchCompleter
    
    var body: some View {
        TextField("Cerca città", text: $query)
            .textFieldStyle(.roundedBorder)
            .padding()
            .onChange(of: query) { newValue in
                guard newValue.count >= 3 else { return }
                debounceWorkItem?.cancel()
                
                let workItem = DispatchWorkItem {
                    searchCompleter.queryFragment = newValue
                }
                
                debounceWorkItem = workItem
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: workItem)
            }
    }
}

#Preview {
    LocationSearchInputView(query: .constant("Mil"), searchCompleter: .constant(MKLocalSearchCompleter()))
}
