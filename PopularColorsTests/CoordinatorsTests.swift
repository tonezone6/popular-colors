//
//  TestableCoordinatorsTests.swift
//  TestableCoordinatorsTests
//
//  Created by Alex S. on 01/09/2023.
//

import Coordinator
import XCTest
@testable import PopularColors

extension AppCoordinator.Destination: AssociatedValue {}
extension NewColorCoordinator.Destination: AssociatedValue {}

class CoordinatorsTests: XCTestCase {
  
  func testEditColor() throws {
    let color = PopularColor(name: "Teal", color: .teal, rating: 10)
    let list = ColorsListModel(colors: [color])
    let coordinator = AppCoordinator(destination: .list(list), navigationController: nil)
    
    list.colorTapped(list.colors[0])
    
    let details = try XCTUnwrap(coordinator.destination.value as? ColorDetailsModel)
    details.color.rating = 5
    details.onUpdate()
    
    _ = try XCTUnwrap(coordinator.destination.value as? ColorsListModel)
    XCTAssertEqual(list.colors[0].rating, 5)
  }
  
  func testDeleteColor() throws {
    let list = ColorsListModel(colors: [.teal])
    let coordinator = AppCoordinator(destination: .list(list), navigationController: nil)
    
    list.colorTapped(list.colors[0])
    
    let details = try XCTUnwrap(coordinator.destination.value as? ColorDetailsModel)
    details.onDelete()
    
    let alert = try XCTUnwrap(coordinator.destination.value as? AlertState<AppCoordinator.AlertAction>)
    alert.send(.deleteColor)
    
    _ = try XCTUnwrap(coordinator.destination.value as? ColorsListModel)
    XCTAssertEqual(list.colors.count, 0)
  }
  
  func testAddNewColor() throws {
    let list = ColorsListModel(colors: [])
    let coordinator = AppCoordinator(destination: .list(list), navigationController: nil)
    
    list.onAddColor()
    
    let child = try XCTUnwrap(coordinator.destination.value as? NewColorCoordinator)
    let intro = try XCTUnwrap(child.destination.value as? NewColorIntroModel)
    intro.onContinue()
    
    let newColor = try XCTUnwrap(child.destination.value as? NewColorModel)
    newColor.color.name = "Awesome color"
    newColor.color.rating = 10
    newColor.onSave()
    
    _ = try XCTUnwrap(coordinator.destination.value as? ColorsListModel)
    XCTAssertEqual(list.colors.count, 1)
    XCTAssertEqual(list.colors[0].name, "Awesome color")
    XCTAssertEqual(list.colors[0].rating, 10)
  }
}
