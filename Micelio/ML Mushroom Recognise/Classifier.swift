//
//  MushroomClassifier.swift
//  Micelio
//
//  Created by Davide Aliti on 26/12/23.
//

import CoreML
import Vision
import CoreImage

struct Classifier {
    
    private(set) var results: [RecognisedMushroom] = []
    
    mutating func detect(ciImage: CIImage) {
        guard let model = try? VNCoreMLModel(for: MicelioMushroomClassifier_v3(configuration: MLModelConfiguration()).model)
        else {
            return
        }
                
        let request = VNCoreMLRequest(model: model)
        
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        
        try? handler.perform([request])
                
        guard let results = request.results as? [VNClassificationObservation] else {
            return
        }
                
        self.results = results.map { RecognisedMushroom(mushroomIdentifier: $0.identifier, confidence: $0.confidence)}
    }
    
}
