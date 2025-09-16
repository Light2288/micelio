//
//  MiCalendarGridLoaderView.swift
//  Micelio
//
//  Created by Davide Aliti on 23/05/25.
//

import SwiftUI

struct MiCalendarGridLoaderView: View {
    private let columns = Array(
        repeating:
            GridItem(
                .flexible(),
                spacing: Constants.MiCalendar.MiCalendarGridLoader.gridSpacing
            ), count: Constants.MiCalendar.MiCalendarGridLoader.gridColumnCount)
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: Constants.MiCalendar.MiCalendarGridLoader.lazyVGridSpacing) {
            ForEach(0..<9) { _ in
                ZStack {
                    RoundedRectangle(
                        cornerRadius: Constants.MiCalendar.MiCalendarGridLoader.roundedRectangleCornerRadius
                    )
                        .fill(
                            Color.gray.opacity(Constants.MiCalendar.MiCalendarGridLoader.roundedRectangleFillOpacity)
                        )
                        .aspectRatio(
                            Constants.MiCalendar.MiCalendarGridLoader.roundedRectangleAspectRatio,
                            contentMode: .fit
                        )
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                }
            }
        }
        .padding(.horizontal, Constants.MiCalendar.MiCalendarGridLoader.lazyVGridHorizontalPadding)
        .padding(.top, Constants.MiCalendar.MiCalendarGridLoader.lazyVGridTopPadding)
    }
}

#Preview {
    MiCalendarGridLoaderView()
}
