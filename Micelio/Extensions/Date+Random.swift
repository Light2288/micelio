//
//  Date+Random.swift
//  Micelio
//
//  Created by Davide Aliti on 11/09/25.
//

import Foundation

extension Date {
  static func random() -> Date {
    let randomTime = TimeInterval(Int32.random(in: 0...Int32.max))
    return Date(timeIntervalSince1970: randomTime)
  }
}
