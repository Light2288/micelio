//
//  LegendListRow.swift
//  Micelio
//
//  Created by Davide Aliti on 03/11/23.
//

import SwiftUI

struct LegendListRow: View {
    let legendItem: LegendItem
    
    var body: some View {
        HStack {
            Image(legendItem.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .padding(8)
                .foregroundStyle(legendItem.iconColor)
                .overlay {
                    RoundedRectangle(cornerSize: CGSize(width: 20, height: 10), style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                        .stroke(.accent, lineWidth: 2)
                }
            Spacer()
            Text(legendItem.text)
        }
        .padding(.horizontal)
    }
}

#Preview {
    LegendListRow(legendItem: legendItems[0])
}
