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
        classifier.results
    }
    
    func detectMushroom(uiImage: UIImage) {
        guard let ciImage = CIImage (image: uiImage) else { return }
        classifier.detect(ciImage: ciImage)
    }
    
}
