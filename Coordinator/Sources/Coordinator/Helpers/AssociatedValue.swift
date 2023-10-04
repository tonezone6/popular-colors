//
//  AssociatedValue.swift
//  TestableCoordinators
//
//  Created by Alex S. on 04/09/2023.
//

public protocol AssociatedValue {
  var value: Any? { get }
}

extension AssociatedValue {
  public var value: Any? {
    Mirror(reflecting: self).children.first?.value
  }
}
