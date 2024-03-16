//
//  MushroomMapAnnotationSheetView.swift
//  Micelio
//
//  Created by Davide Aliti on 20/02/24.
//

import SwiftUI
import CoreLocation

struct MushroomMapAnnotationSheetView: View {
    @Binding var annotation: MushroomMapAnnotation?
    @Binding var isAnnotationEditMode: Bool
    @Binding var centerMapOnLocation: (CLLocationCoordinate2D) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.MushroomMap.AnnotationSheet.vStackSpacing) {
            AnnotationSheetButtonHStackView(isAnnotationEditMode: $isAnnotationEditMode, annotation: $annotation, centerMapOnLocation: $centerMapOnLocation)
            if isAnnotationEditMode {
                AnnotationEditView(annotation: $annotation, centerMapOnLocation: $centerMapOnLocation)
            } else {
                AnnotationDisplayView(annotation: annotation)
            }
            Spacer()
        }
        .padding([.top, .horizontal])
    }
}

#Preview {
    func animatedCenterMap(on: CLLocationCoordinate2D) -> () {
        return
    }
    
    return MushroomMapAnnotationSheetView(annotation: .constant(nil), isAnnotationEditMode: .constant(false), centerMapOnLocation: .constant(animatedCenterMap(on:)))
}
