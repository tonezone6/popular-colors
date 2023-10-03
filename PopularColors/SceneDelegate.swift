//
//  SceneDelegate.swift
//  TestableCoordinators
//
//  Created by Alex S. on 01/09/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  let coordinator = AppCoordinator.list
  var window: UIWindow?
  var isTesting: Bool {
    NSClassFromString("XCTestCase") != nil
  }
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let scene = (scene as? UIWindowScene), !isTesting else { return }
    window = UIWindow(windowScene: scene)
    window?.rootViewController = coordinator.navigationController
    window?.makeKeyAndVisible()
    
    //    Task {
    //      try? await Task.sleep(for: .seconds(2))
    //      coordinator.navigateToAddNewColor()
    //    }
  }
}


extension AppCoordinator {
  static let list = AppCoordinator(
    destination: .list(
      ColorsListModel(
        colors: PopularColor.allColors
      )
    )
  )
  
  func navigateToAddNewColor() {
    guard case .list(let list) = destination else { return }
    list.onAddColor()
    guard case .newColor(let newColor) = destination,
          case .intro(let intro) = newColor.destination else { return }
    intro.onContinue()
  }
  
  func navigateToDeleteAlert(color: PopularColor) {
    guard case .list(let list) = destination else { return }
    guard let index = list.colors.firstIndex(where: { $0.name == color.name }) else { return }
    let matched = list.colors[index]
    list.onColorTap(matched)
    guard case .details(let details) = destination else { return }
    details.onDelete()
  }
}
