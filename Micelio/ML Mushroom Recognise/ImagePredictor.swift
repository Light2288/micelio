//
//  ImagePredictor.swift
//  Micelio
//
//  Created by Davide Aliti on 26/01/24.
//

import Vision
import UIKit


struct ImagePredictor {
    
    private(set) var predictions: [Prediction] = []
    
    static func createImageClassifier() -> VNCoreMLModel {
        let defaultConfig = MLModelConfiguration()
        let imageClassifierWrapper = try? MobileNetV2(configuration: defaultConfig)
        
        guard let imageClassifier = imageClassifierWrapper else {
            fatalError("App failed to create an image classifier model instance.")
        }
        
        let imageClassifierModel = imageClassifier.model
        
        guard let imageClassifierVisionModel = try? VNCoreMLModel(for: imageClassifierModel) else {
            fatalError("App failed to create a `VNCoreMLModel` instance.")
        }
        
        return imageClassifierVisionModel
    }
    
    private static let imageClassifier = createImageClassifier()
    
    private func createImageClassificationRequest() -> VNImageBasedRequest {
        let imageClassificationRequest = VNCoreMLRequest(model: ImagePredictor.imageClassifier)
        
        imageClassificationRequest.imageCropAndScaleOption = .centerCrop
        return imageClassificationRequest
    }
    
    mutating func makePredictions(for image: UIImage) {
        let orientation = CGImagePropertyOrientation(image.imageOrientation)
        
        guard let photoImage = image.cgImage else {
            fatalError("Photo doesn't have underlying CGImage.")
        }
        
        let imageClassificationRequest = createImageClassificationRequest()
        
        let handler = VNImageRequestHandler(cgImage: photoImage, orientation: orientation)
        let request: VNRequest = imageClassificationRequest
        
        try? handler.perform([request])
        
        guard let results = request.results, let observations = results as? [VNClassificationObservation] else {
            print("VNRequest produced no results or the wrong result type.")
            return
        }
        
        self.predictions = observations.map { observation in
            Prediction(classification: observation.identifier,
                       confidence: observation.confidence)
        }
    }
}
