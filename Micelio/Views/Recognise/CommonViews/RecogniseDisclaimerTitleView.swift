//
//  RecogniseDisclaimerTitleView.swift
//  Micelio
//
//  Created by Davide Aliti on 09/01/24.
//

import SwiftUI

struct RecogniseDisclaimerTitleView: View {
    var body: some View {
        HStack {
            Spacer()
            WarningSignView()
            Spacer()
            Text("Attenzione!")
            Spacer()
            WarningSignView()
            Spacer()
        }
        .font(.body)
        .fontWeight(.bold)
        .padding(.bottom, Constants.Recognise.RecogniseDisclaimer.Title.bottomPadding)
    }
}

struct WarningSignView: View {
    var body: some View {
        Image(systemName: "exclamationmark.triangle.fill")
            .foregroundStyle(.orange)
    }
}

#Preview {
    RecogniseDisclaimerTitleView()
}
