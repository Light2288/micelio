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
    let isListElementDeletable: Bool
    let onDelete: (MiCalendarSavedLocation) -> Void
    let onClearAll: () -> Void
    
    @Binding var locations: [MiCalendarSavedLocation]
    
    @State private var showDeleteAllAlert = false
    @State private var locationToDelete: MiCalendarSavedLocation?
    
    var body: some View {
        if !locations.isEmpty {
            Section(
                header:
                    HStack {
                        Text(title)
                        Spacer()
                        if isListDeletable {
                            Button(role: .destructive) {
                                showDeleteAllAlert = true
                            } label: {
                                Image(systemName: "trash")
                                    .font(.caption)
                            }
                            .alert("Eliminare l'intera lista?", isPresented: $showDeleteAllAlert) {
                                Button("Annulla", role: .cancel) {}
                                Button("Elimina", role: .destructive) {
                                    onClearAll()
                                }
                            }
                        }
                    }
            ) {
                ForEach(locations, id: \.self) { location in
                    Button(location.name) {
                        setSelectedLocation(location)
                        dismiss()
                    }
                    .if(isListElementDeletable) { view in
                        view.swipeActions {
                            Button(role: .destructive) {
                                onDelete(location)
                            } label: {
                                Label("Elimina", systemImage: "trash")
                            }
                        }
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
        isListElementDeletable: false,
        onDelete: { _ in },
        onClearAll: { },
        locations: .constant([])
    )
}
