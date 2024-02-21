//
//  AnnotationDisplayView.swift
//  Micelio
//
//  Created by Davide Aliti on 21/02/24.
//

import SwiftUI

struct AnnotationDisplayView: View {
    var annotation: MushroomMapAnnotation?
    
    var body: some View {
        Text("Coordinate: (lat. \((annotation?.latitude.roundTo(places: 6) ?? 0)) ;  lon. \(annotation?.longitude.roundTo(places: 6) ?? 0))")
            .font(.footnote)
        Text("Tipologia fungo: \(annotation?.mushroomName ?? "")")
        if let notes = annotation?.notes, !notes.isEmpty {
            Text("Note: \(notes)")
        }
        Spacer()
    }
}

#Preview {
    AnnotationDisplayView()
}
