//
//  DisclosureGroupCustomStyle.swift
//  Micelio
//
//  Created by Davide Aliti on 09/11/23.
//

import SwiftUI

struct DisclosureGroupCustomStyle: DisclosureGroupStyle {
    var image: String
    
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            Button {
                withAnimation {
                    configuration.isExpanded.toggle()
                }
            } label: {
                HStack(alignment: .center) {
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: Constants.Styles.DisclosureGroupCustomStyle.imageDimension, height: Constants.Styles.DisclosureGroupCustomStyle.imageDimension)
                        .foregroundStyle(.accent)
                    configuration.label
                        .foregroundStyle(.accent)
                    Spacer()
                    Text(configuration.isExpanded ? "Nascondi" : "Mostra")
                        .foregroundColor(.accentColor)
                        .font(.caption.lowercaseSmallCaps())
                        .animation(nil, value: configuration.isExpanded)
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            if configuration.isExpanded {
                configuration.content
                    .padding(.top, Constants.Styles.DisclosureGroupCustomStyle.expandedTopPadding)
            }
        }
    }
}
