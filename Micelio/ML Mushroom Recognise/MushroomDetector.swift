//
//  MushroomDetector.swift
//  Micelio
//
//  Created by Davide Aliti on 26/01/24.
//

import SwiftUI

class MushroomDetector: ObservableObject {
    
    @Published private var imagePredictor = ImagePredictor()
    
    var predictions: [Prediction] {
        imagePredictor.predictions
    }
    
    var mushroomDetected: Bool {
        self.predictions
            .filter { $0.confidence >= 0.2 }
            .map {  Constants.MushroomClassifier.mobileNetMushroomClassifications.contains(where: $0.classification.lowercased().contains) }
            .contains(true)
            
    }
    
    func detectMushroom(uiImage: UIImage) {
        imagePredictor.makePredictions(for: uiImage)
    }
    
}

