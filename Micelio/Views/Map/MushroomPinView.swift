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
    
    private let shadowRadius = Constants.MushroomMap.MushroomPin.shadowRadius
    private let frameHeight = Constants.MushroomMap.MushroomPin.frameHeight
    private let selectedScale = Constants.MushroomMap.MushroomPin.selectedScale
    private let defaultScale = Constants.MushroomMap.MushroomPin.defaultScale
    private let animationDuration = Constants.MushroomMap.MushroomPin.animationDuration
    private let animationDamping = Constants.MushroomMap.MushroomPin.animationDamping
    
    private var isSelected: Bool {
        selectedMushroomMapAnnotation == mushroomMapAnnotation
    }
    
    private var pinColor: Color {
        MushroomMapAnnotation.colors[mushroomMapAnnotation.color ?? "accent"] ?? .accent
    }
    
    var body: some View {
        Image("mushroom-pin")
            .resizable()
            .scaledToFit()
            .scaleEffect(isSelected ? selectedScale : defaultScale)
            .foregroundStyle(pinColor)
            .shadow(color: Color(.systemBackground), radius: shadowRadius)
            .frame(height: frameHeight)
            .offset(y: -frameHeight / 2)
            .animation(.spring(response: animationDuration, dampingFraction: animationDamping, blendDuration: 0), value: selectedMushroomMapAnnotation)
            .onTapGesture(perform: handleTap)
    }
    
    
    private func handleTap() {
        selectedMushroomMapAnnotation = mushroomMapAnnotation
        showSheet = true
        isEditAnnotationMode = false
        centerOnPinPositionClosure(
            CLLocationCoordinate2D(
                latitude: mushroomMapAnnotation.latitude - manager.region.span.latitudeDelta / 3,
                longitude: mushroomMapAnnotation.longitude
            ),
            false
        )
    }
}

#Preview {
    func centerOnPinPositionClosure(location: CLLocationCoordinate2D, isEditAnnotationMode: Bool) -> () {
        return
    }
    
    return MushroomPinView(mushroomMapAnnotation: MushroomMapAnnotation(context: PersistenceController.preview.container.viewContext), selectedMushroomMapAnnotation: .constant(nil), showSheet: .constant(true), isEditAnnotationMode: .constant(false), centerOnPinPositionClosure: centerOnPinPositionClosure, manager: LocationManager())
}
