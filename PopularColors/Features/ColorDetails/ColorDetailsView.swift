//
//  ContentView.swift
//  TestableCoordinators
//
//  Created by Alex S. on 01/09/2023.
//

import SwiftUI

struct ColorDetailsView: View {
  @ObservedObject var model: ColorDetailsModel
  
  var body: some View {
    Form {
      HStack {
        Text("About")
          .foregroundColor(.secondary)
        Spacer()
        Circle().fill(model.color.color)
          .frame(height: 30)
      }
      Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
        .foregroundColor(.secondary)
      
      Stepper(
        "Rating: \(model.color.rating)",
        value: $model.color.rating, in: 1...10
      )
      Button("Update") {
        model.updateColorButtonTapped()
      }
      .disabled(model.isUpdateDisabled)
    }
    .safeAreaInset(edge: .bottom) {
      Button("Delete") {
        model.deleteColorButtonTapped()
      }
      .buttonStyle(.bordered)
      .tint(.red)
      .padding()
    }
    .navigationTitle(model.color.name)
  }
}

#Preview {
  ColorDetailsView(
    model: ColorDetailsModel(
      color: PopularColor(name: "Teal", color: .teal, rating: 9)
    )
  )
}
