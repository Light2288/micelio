//
//  MiCalendarDayRulesConfigManager.swift
//  Micelio
//
//  Created by Davide Aliti on 14/04/25.
//

import SwiftUI

class MiCalendarDayRulesConfigManager: ObservableObject {
    @Published var configs: MiCalendarDayRulesConfig {
        didSet {
            save()
        }
    }
    
    private let key = "calendarRules"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode(MiCalendarDayRulesConfig.self, from: data) {
            self.configs = decoded
        } else {
            self.configs = MiCalendarDayRulesConfig()
        }
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(configs),
           !encoded.isEmpty {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
}
