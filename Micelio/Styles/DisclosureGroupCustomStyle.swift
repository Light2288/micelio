//
//  DisclosureGroupCustomStyle.swift
//  Micelio
//
//  Created by Davide Aliti on 09/11/23.
//

import SwiftUI

struct DisclosureGroupCustomStyle: DisclosureGroupStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            Button {
                withAnimation {
                    configuration.isExpanded.toggle()
                }
            } label: {
                HStack(alignment: .firstTextBaseline) {
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
                    .padding(.top, 1)
            }
        }
    }
}
