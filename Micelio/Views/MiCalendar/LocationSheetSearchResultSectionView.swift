//
//  LocationSheetSearchResultSectionView.swift
//  Micelio
//
//  Created by Davide Aliti on 23/06/25.
//

import SwiftUI

struct LocationSheetSearchResultSectionView: View {
    @Environment(\.dismiss) private var dismiss
    let title: String
    let setSelectedLocation: (MiCalendarSavedLocation) -> Void
    let isListDeletable: Bool
    
    @Binding var locations: [MiCalendarSavedLocation]
    
    var body: some View {
        if !locations.isEmpty {
            Section(
                header:
                    HStack {
                        Text(title)
                        Spacer()
                        if isListDeletable {
                            Button(role: .destructive) {
                                locations.removeAll()
                            } label: {
                                Image(systemName: "trash")
                                    .font(.caption)
                            }
                        }
                    }
            ) {
                ForEach(locations, id: \.self) { location in
                    Button(location.name) {
                        setSelectedLocation(location)
                        dismiss()
                    }
                }
            }
        } else {
            EmptyView()
        }
    }
}

#Preview {
    LocationSheetSearchResultSectionView(
        title: "Risultati",
        setSelectedLocation: ({ _ in }),
        isListDeletable: false,
        locations: .constant([])
    )
}
