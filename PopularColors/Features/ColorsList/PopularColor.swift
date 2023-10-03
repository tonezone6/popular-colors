//
//  ColorItem.swift
//  TestableCoordinators
//
//  Created by Alex S. on 01/09/2023.
//

import SwiftUI

struct PopularColor: Identifiable, Equatable {
  let id = UUID()
  var name: String
  var color: Color
  var rating: Int
}

extension PopularColor {
  static let teal = PopularColor(name: "Teal", color: .teal, rating: 10)
  static let allColors: [PopularColor] = [
    PopularColor(name: "Blue", color: .blue, rating: 10),
    PopularColor(name: "Orange", color: .orange, rating: 8),
    PopularColor(name: "Brown", color: .brown, rating: 4),
    PopularColor(name: "Teal", color: .teal, rating: 6),
    PopularColor(name: "Indigo", color: .indigo, rating: 7),
    PopularColor(name: "Mint", color: .mint, rating: 9)
  ]
}
