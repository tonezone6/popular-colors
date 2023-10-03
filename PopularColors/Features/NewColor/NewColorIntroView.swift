//
//  AddColorIntro.swift
//  TestableCoordinators
//
//  Created by Alex S. on 01/09/2023.
//

import SwiftUI

struct NewColorIntroView: View {
  @ObservedObject var model: NewColorIntroModel
    
  var body: some View {
    Form {
      Text("Random color")
      Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
        .foregroundColor(.secondary)
      Button("Continue") {
        model.continueButtonTapped()
      }
    }
    .toolbar {
      ToolbarItem(placement: .cancellationAction) {
        Button(action: { model.dismissButtonTapped() }) {
          Image(systemName: "xmark.circle.fill")
            .resizable()
            .scaledToFit()
            .frame(height: 24)
            .foregroundColor(.gray)
        }
      }
    }
    .navigationTitle("Intro")
    .navigationBarTitleDisplayMode(.inline)
  }
}

#Preview {
  NavigationStack {
    NewColorIntroView(model: NewColorIntroModel())
  }
}
