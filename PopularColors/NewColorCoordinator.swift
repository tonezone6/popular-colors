//
//  AboutCoordinator.swift
//  TestableCoordinators
//
//  Created by Alex S. on 01/09/2023.
//

import Coordinator
import SwiftUI
import UIKit

final class NewColorCoordinator: Coordinator {
  let navigationController: UINavigationController?
  var navigationPath: [Destination] = []
    
  enum Destination {
    case intro(NewColorIntroModel)
    case newColor(NewColorModel)
  }
  
  // Delegate closures
  var onFinish: (PopularColor) -> Void = { _ in }
  
  init(
    destination: Destination,
    navigationController: UINavigationController? = .init()
  ) {
    self.navigationController = navigationController
    self.navigationController?.navigationBar.changeAppearence(
      backgroundColor: .white,
      foregroundColor: .darkGray
    )
    self.navigate(to: destination)
  }
  
  func action(for destination: Destination) -> DestinationAction {
    switch destination {
    case .intro(let intro):
      intro.onContinue = { [weak self] in
        self?.navigate(to: .newColor(NewColorModel()))
      }
      intro.onDismiss = { [weak self] in
        self?.dismissPresented()
      }
      let view = NewColorIntroView(model: intro)
      let vc = UIHostingController(rootView: view)
      return .push(vc)
    
    case .newColor(let newColor):
      newColor.onSave = { [weak self] in
        self?.onFinish(newColor.color)
      }
      let view = NewColorView(model: newColor)
      let vc = UIHostingController(rootView: view)
      return .push(vc)
    }
  }
}
