//
//  MiCalendarDayRulesConfigManager.swift
//  Micelio
//
//  Created by Davide Aliti on 14/04/25.
//

import SwiftUI

class MiCalendarRulesConfigManager: ObservableObject {
    @Published var configs: MiCalendarRulesConfig {
        didSet {
            save()
        }
    }
    
    private let key = "calendarRules"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode(MiCalendarRulesConfig.self, from: data) {
            self.configs = decoded
        } else {
            self.configs = MiCalendarRulesConfig()
        }
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(configs),
           !encoded.isEmpty {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
}
