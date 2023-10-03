//
//  NavigationModifier.swift
//  TestableCoordinators
//
//  Created by Alex S. on 04/09/2023.
//

import SwiftUI

public extension UINavigationBar {
  func changeAppearence(
    backgroundColor: UIColor,
    foregroundColor: UIColor,
    tintColor: UIColor? = nil,
    hideSeparator: Bool? = false,
    backSystemImage: String? = nil
  ) -> Void {
    let appearence = UINavigationBarAppearance()
    appearence.largeTitleTextAttributes = [.foregroundColor : foregroundColor]
    appearence.titleTextAttributes = [.foregroundColor : foregroundColor]
    appearence.configureWithOpaqueBackground()
    appearence.backgroundColor = backgroundColor
    
    if let hideSeparator = hideSeparator, hideSeparator {
      appearence.shadowImage = UIImage()
      appearence.shadowColor = .clear
    }
    if let backSystemImage = backSystemImage {
      let backImage = UIImage(systemName: backSystemImage)?.withTintColor(tintColor ?? foregroundColor)
      appearence.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
    }
    self.tintColor = tintColor
    self.scrollEdgeAppearance = appearence
    self.compactAppearance = appearence
    self.standardAppearance = appearence
  }
  
  /// Hide back button text
  //  override func viewWillLayoutSubviews() {
  //    super.viewWillLayoutSubviews()
  //    navigationBar.topItem?.backButtonDisplayMode = .minimal
  //  }
}
