//
//  Coordinator.swift
//  TestableCoordinators
//
//  Created by Alex S. on 01/09/2023.
//

import UIKit

public enum DestinationAction {
  case push(UIViewController, animated: Bool = true)
  case pop(animated: Bool = true)
  case present(UIViewController, style: UIModalPresentationStyle = .automatic)
  case dismiss(animated: Bool = true)
  case none
}

public protocol Coordinator: AnyObject {
  associatedtype Destination
  var navigationController: UINavigationController? { get }
  var navigationPath: [Destination] { get set }
  func action(for destination: Destination) -> DestinationAction
}

public extension Coordinator {
  var destination: Destination {
    guard let path = navigationPath.last else {
      fatalError("navigation path cannot be empty")
    }
    return path
  }
  
  func navigate(to destination: Destination) {
    navigationPath.append(destination)
    perform(action(for: destination))
  }
  
  func navigateBack(animated: Bool = true) {
    guard navigationPath.count > 1 else { fatalError() }
    navigationPath.removeLast()
    perform(.pop(animated: animated))
  }

  func dismissPresented(animated: Bool = true) {
    navigationPath.removeLast()
    perform(.dismiss(animated: animated))
  }
}

private extension Coordinator {
  func perform(_ action: DestinationAction) {
    switch action {
    case .push(let vc, let animated):
      navigationController?.pushViewController(vc, animated: animated)
      
    case .pop(let animated):
      navigationController?.popViewController(animated: animated)
    
    case .present(let vc, let style):
      vc.modalPresentationStyle = style
      if let controller = navigationController?.presentedViewController {
        controller.present(vc, animated: true, completion: nil)
      } else {
        navigationController?.topViewController?
          .present(vc, animated: true, completion: nil)
      }
    
    case .dismiss(let animated):
      if let vc = navigationController?.presentedViewController {
        vc.dismiss(animated: animated, completion: nil)
      } else {
        navigationController?.topViewController?
          .dismiss(animated: animated, completion: nil)
      }
    
    case .none: break
    }
  }
}
