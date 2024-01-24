//
//  ChooseAnotherPhotoTextView.swift
//  Micelio
//
//  Created by Davide Aliti on 05/01/24.
//

import SwiftUI

struct ChooseAnotherPhotoTextView: View {
    var body: some View {
        Text("oppure scegli un'altra fotografia:")
            .font(.title2)
            .fontWeight(.semibold)
            .multilineTextAlignment(.center)
            .padding()
    }
}

#Preview {
    ChooseAnotherPhotoTextView()
}
