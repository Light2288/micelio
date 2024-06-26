//
//  GroupByMenuView.swift
//  Micelio
//
//  Created by Davide Aliti on 24/06/24.
//

import SwiftUI

struct GroupByMenuView: View {
    @Binding var groupBy: CatalogGroupBy
    
    var body: some View {
        Menu {
            Text("Raggruppa per:")
            Picker("", selection: $groupBy) {
                ForEach(CatalogGroupBy.allCases) {
                    Text($0.groupByTitle)
                        .tag($0)
                }
            }
            .pickerStyle(.inline)
        } label: {
            Image("group-list")
        }
    }
}

#Preview {
    GroupByMenuView(groupBy: .constant(.initialLetter))
}
