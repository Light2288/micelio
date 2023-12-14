//
//  RecogniseView.swift
//  Micelio
//
//  Created by Davide Aliti on 14/12/23.
//

import SwiftUI

enum DisplayedView: String, CaseIterable, Identifiable {
    var id: Int {
        self.hashValue
    }
    
    var pickerText: String {
        switch self {
        case .camera: return "Fotocamera"
        case .gallery: return "Galleria"
        }
    }
    
    case camera
    case gallery
}

struct RecogniseView: View {
    @State var displayedView: DisplayedView = .camera
    
    var body: some View {
        VStack {
            Group {
                switch displayedView {
                case .camera:
                    CameraView()
                case .gallery:
                    GalleryView()
                }
            }
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.green)
            
            
            Picker("", selection: $displayedView) {
                ForEach(DisplayedView.allCases) {
                    Text($0.pickerText)
                        .tag($0)
                }
            }
            .pickerStyle(.segmented)
            .padding()
        }
    }
}

#Preview {
    RecogniseView()
}
