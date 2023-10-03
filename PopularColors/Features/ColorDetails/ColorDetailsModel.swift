//
//  ColorDetailsModel.swift
//  TestableCoordinators
//
//  Created by Alex S. on 01/09/2023.
//

import Foundation
import SwiftUI

class ColorDetailsModel: ObservableObject {
  @Published var color: PopularColor
  private let initialColor: PopularColor
  
  var isUpdateDisabled: Bool {
    color == initialColor
  }
  // Delegate closures
  var onUpdate: () -> Void = {}
  var onDelete: () -> Void = {}
  
  init(color: PopularColor) {
    self.color = color
    self.initialColor = color
  }
  
  func updateColorButtonTapped() {
    onUpdate()
  }
  
  func deleteColorButtonTapped() {
    onDelete()
  }
}
