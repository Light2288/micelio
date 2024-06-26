//
//  RecogniseImageStyle.swift
//  Micelio
//
//  Created by Davide Aliti on 04/01/24.
//

import Foundation
import SwiftUI

extension Image {
    func recogniseImageStyle() -> some View {
        self
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerSize: Constants.Styles.RecogniseImageStyle.cornerRadius))
            .padding()
    }
}
