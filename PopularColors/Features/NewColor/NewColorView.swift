//
//  EditColorView.swift
//  TestableCoordinators
//
//  Created by Alex S. on 01/09/2023.
//

import SwiftUI

struct NewColorView: View {
  @ObservedObject var model: NewColorModel
  
  var body: some View {
    Form {
      Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
        .foregroundColor(.secondary)
      TextField("Color name", text: $model.color.name)
      Stepper(
        "Rating: \(model.color.rating)",
        value: $model.color.rating, in: 1...10
      )
      Button("Save") {
        model.saveButtonTapped()
      }
      .disabled(model.color.name.isEmpty)
    }
    .navigationTitle("New color")
    .navigationBarTitleDisplayMode(.inline)
  }
}

#Preview {
  NewColorView(model: NewColorModel())
}
