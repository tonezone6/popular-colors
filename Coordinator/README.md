# Coordinator

Swift package containing the coordinator isolated logic that can be extracted in the future to a separated remote repository.   

```swift
protocol Coordinator {
  associatedtype Destination
  var navigationController: UINavigationController? { get }
  var navigationPath: [Destination] { get set }
  func action(for destination: Destination) -> DestinationAction
}
```

The package also comes with a few helpers.

* `UINavigationBar`, `change(appearence:)` helper method
* `AlertState` helper with the `UIAlertController` `init(alertState:prefferedStyle:)` extension
* `AssociatedValue` protocol for easily extract the associated values from the coordinator `Destination`
