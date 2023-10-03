//
//  AppCoordinator.swift
//  TestableCoordinators
//
//  Created by Alex S. on 01/09/2023.
//

import Coordinator
import SwiftUI
import UIKit

final class AppCoordinator: Coordinator {
  let navigationController: UINavigationController?
  var navigationPath: [Destination] = []
    
  enum Destination {
    case deleteColor(AlertState<AlertAction>)
    case details(ColorDetailsModel)
    case list(ColorsListModel)
    case newColor(NewColorCoordinator)
  }
  
  enum AlertAction {
    case deleteColor
  }
        
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
    case .list(let list):
      list.onAddColor = { [weak self] in
        let addColor = NewColorCoordinator(destination: .intro(NewColorIntroModel()))
        addColor.onFinish = { [weak self] color in
          list.perform(.save, color)
          self?.dismissPresented()
        }
        self?.navigate(to: .newColor(addColor))
      }
      list.onColorTap = { [weak self] color in
        let details = ColorDetailsModel(color: color)
        self?.navigate(to: .details(details))
        details.onUpdate = { [weak self] in
          self?.navigateBack()
          list.perform(.update, details.color)
        }
        details.onDelete = { [weak self] in
          let alert = AlertState.delete(details.color) { [weak self] _ in
            /// Since the alert is dismissed automatically,
            /// we need to clear out the path manually.
            self?.navigationPath.removeLast()
            /// Here, there is no need to switch
            /// since we only have one action
            self?.navigateBack()
            list.perform(.delete, color)
          }
          self?.navigate(to: .deleteColor(alert))
        }
      }
      let view = ColorsList(model: list)
      let vc = UIHostingController(rootView: view)
      return .push(vc)
      
    case .details(let model):
      let view = ColorDetailsView(model: model)
      let vc = UIHostingController(rootView: view)
      return .push(vc)
      
    case .newColor(let coordinator):
      return .present(coordinator.navigationController!)
      
    case .deleteColor(let alertState):
      return .present(UIAlertController(alertState: alertState))
    }
  }
}

// MARK: - Alerts

extension AlertState where Action == AppCoordinator.AlertAction {
  static func delete(
    _ color: PopularColor,
    action: @escaping (Action) -> Void
  ) -> AlertState {
    .init(
      title: "Delete color?",
      message: "Are you sure you want to delete \(color.name) color?",
      buttons: [
        AlertButton(title: "Cancel", style: .cancel),
        AlertButton(title: "Delete", style: .destructive, action: .deleteColor)
      ],
      send: action
    )
  }
}

