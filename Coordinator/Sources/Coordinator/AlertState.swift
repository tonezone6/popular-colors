//
//  AlertState.swift
//  TestableCoordinators
//
//  Created by Alex S. on 03/09/2023.
//

import UIKit

public struct AlertState<Action> {
  public let title: String
  public let message: String
  public let buttons: [AlertButton]
  public let send: (Action) -> Void
    
  public struct AlertButton {
    public let title: String
    public let style: UIAlertAction.Style
    public var action: Action? = nil
    
    public init(
      title: String,
      style: UIAlertAction.Style = .default,
      action: Action? = nil
    ) {
      self.title = title
      self.style = style
      self.action = action
    }
  }
  
  public init(
    title: String,
    message: String,
    buttons: [AlertButton],
    send: @escaping (Action) -> Void
  ) {
    self.title = title
    self.message = message
    self.buttons = buttons
    self.send = send
  }
}

public extension UIAlertController {
  convenience init<Action>(
    alertState: AlertState<Action>,
    preferredStyle: UIAlertController.Style = .alert
  ) {
    self.init(
      title: alertState.title,
      message: alertState.message,
      preferredStyle: preferredStyle
    )
    if alertState.buttons.isEmpty {
      self.addAction(
        UIAlertAction(
          title: NSLocalizedString("OK", comment: "Default action"),
          style: .cancel
        )
      )
    } else {
      for button in alertState.buttons {
        self.addAction(
          UIAlertAction(
            title: button.title,
            style: button.style,
            handler: { _ in
              if let action = button.action {
                alertState.send(action)
              }
            }
          )
        )
      }
    }
  }
}
