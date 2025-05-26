//
//  MiCalendarToolbarView.swift
//  Micelio
//
//  Created by Davide Aliti on 23/05/25.
//

import SwiftUI

struct MiCalendarToolbar: ToolbarContent {
    @Binding var showFilters: Bool
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button(action: { showFilters.toggle() }) {
                Image(systemName: "gear")
            }
        }
    }
}
