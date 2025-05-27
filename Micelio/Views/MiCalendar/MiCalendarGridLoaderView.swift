//
//  MiCalendarGridLoaderView.swift
//  Micelio
//
//  Created by Davide Aliti on 23/05/25.
//

import SwiftUI

struct MiCalendarGridLoaderView: View {
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 2), count: 3)
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 2) {
            ForEach(0..<9) { _ in
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.2))
                        .aspectRatio(1.0, contentMode: .fit)
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                }
            }
        }
        .padding(.horizontal, 4)
        .padding(.top, 16)
    }
}

#Preview {
    MiCalendarGridLoaderView()
}
