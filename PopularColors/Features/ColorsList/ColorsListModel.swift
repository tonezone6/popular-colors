//
//  ColorsListModel.swift
//  TestableCoordinators
//
//  Created by Alex S. on 01/09/2023.
//

import SwiftUI

class ColorsListModel: ObservableObject {
  @Published var colors: [PopularColor]

  var sorted: [PopularColor] {
    colors.sorted(by: { $0.rating > $1.rating })
  }
  
  // Delegate closures
  var onAddColor: () -> Void = {}
  var onColorTap: (PopularColor) -> Void = { _ in }
  
  init(colors: [PopularColor]) {
    self.colors = colors
  }
  
  func addColorButtonTapped() {
    onAddColor()
  }
  
  func colorTapped(_ color: PopularColor) {
    onColorTap(color)
  }
  
  enum Action {
    case delete, save, update
  }
  
  func perform(_ action: Action, _ color: PopularColor) {
    if action == .save {
      colors.append(color)
    }
    guard let index = colors.firstIndex(
      where: { $0.id == color.id }) else {
      return
    }
    if action == .update {
      colors[index] = color
    }
    if action == .delete {
      colors.remove(at: index)
    }
  }
}
