//
//  MushroomClassifier.swift
//  Micelio
//
//  Created by Davide Aliti on 26/12/23.
//

import SwiftUI

class MushroomClassifier: ObservableObject {
    
    @Published private var classifier = Classifier()
    
    var recognisedMushrooms: [RecognisedMushroom] {
        classifier.results.filter { $0.confidence > Constants.MushroomClassifier.minConfidence }
    }
    
    func recogniseMushroom(uiImage: UIImage) {
        guard let ciImage = CIImage (image: uiImage) else { return }
        classifier.recognise(ciImage: ciImage)
    }
    
}
