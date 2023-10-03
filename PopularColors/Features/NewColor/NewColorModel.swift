//
//  EditColorModel.swift
//  TestableCoordinators
//
//  Created by Alex S. on 01/09/2023.
//

import Foundation
import SwiftUI

class NewColorModel: ObservableObject {
  @Published var color: PopularColor
  
  private let availableColors: [Color] = [
    .red, .green, .blue,
    .cyan, .gray, .indigo,
    .pink, .purple, .yellow
  ]
  
  // Delegate closure
  var onSave: () -> Void = {}
  
  init() {
    self.color = PopularColor(name: "", color: .black, rating: 5)
  }
  
  func saveButtonTapped() {
    color.color = availableColors.randomElement() ?? .black
    onSave()
  }
}
