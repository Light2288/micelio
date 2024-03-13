//
//  MushroomPinView.swift
//  Micelio
//
//  Created by Davide Aliti on 09/02/24.
//

import SwiftUI
import CoreLocation

struct MushroomPinView: View {
    let mushroomMapAnnotation: MushroomMapAnnotation
    @Binding var selectedMushroomMapAnnotation: MushroomMapAnnotation?
    @Binding var showSheet: Bool
    @Binding var isEditAnnotationMode: Bool
    
    let centerOnPinPositionClosure: (CLLocationCoordinate2D, Bool) -> Void
    let manager: LocationManager
    
    var body: some View {
        Image("mushroom-pin")
            .resizable()
            .scaledToFit()
            .scaleEffect(selectedMushroomMapAnnotation == mushroomMapAnnotation ? 1 : 0.6)
            .foregroundStyle(MushroomMapAnnotation.colors[mushroomMapAnnotation.color ?? "accent"] ?? .accent)
            .shadow(color: Color(.systemBackground), radius: Constants.MushroomMap.MushroomPin.shadowRadius)
            .frame(height: Constants.MushroomMap.MushroomPin.frameHeight)
            .offset(y: -Constants.MushroomMap.MushroomPin.frameHeight/2)
            .animation(.spring(response: 0.30, dampingFraction: 0.25, blendDuration: 0), value: selectedMushroomMapAnnotation)
            .onTapGesture {
                selectedMushroomMapAnnotation = mushroomMapAnnotation
                showSheet = true
                isEditAnnotationMode = false
                centerOnPinPositionClosure(CLLocationCoordinate2D(latitude: mushroomMapAnnotation.latitude-manager.region.span.latitudeDelta/3, longitude: mushroomMapAnnotation.longitude), false)
            }
    }
}

#Preview {
    func centerOnPinPositionClosure(location: CLLocationCoordinate2D, isEditAnnotationMode: Bool) -> () {
        return
    }
    
    return MushroomPinView(mushroomMapAnnotation: MushroomMapAnnotation(context: PersistenceController.preview.container.viewContext), selectedMushroomMapAnnotation: .constant(nil), showSheet: .constant(true), isEditAnnotationMode: .constant(false), centerOnPinPositionClosure: centerOnPinPositionClosure, manager: LocationManager())
}
