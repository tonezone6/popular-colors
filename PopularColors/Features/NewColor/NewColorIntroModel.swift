//
//  AddColorIntroModel.swift
//  TestableCoordinators
//
//  Created by Alex S. on 01/09/2023.
//

import Foundation

class NewColorIntroModel: ObservableObject {
  // Delegate closures
  var onContinue: () -> Void = {}
  var onDismiss: () -> Void = {}
  
  func continueButtonTapped() {
    onContinue()
  }
  
  func dismissButtonTapped() {
    onDismiss()
  }
}
