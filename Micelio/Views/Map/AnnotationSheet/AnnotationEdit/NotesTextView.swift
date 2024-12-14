//
//  NotesTextView.swift
//  Micelio
//
//  Created by Davide Aliti on 10/03/24.
//

import SwiftUI

struct NotesTextView: View {
    
    @Binding var notes: String
    
    private let vStackSpacing = Constants.MushroomMap.AnnotationSheet.EditView.NotesText.vStackSpacing
    
    var body: some View {
        VStack(alignment: .leading, spacing: vStackSpacing) {
            Text("Note")
            TextField("Informazioni aggiuntive", text: $notes, axis: .vertical)
                .lineLimit(1...4)
                .textFieldStyle(.roundedBorder)
        }
        .font(.subheadline)
    }
}

#Preview {
    NotesTextView(notes: .constant(""))
}
