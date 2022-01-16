# Expenser
Expenser application lets you save and track your expenses. It comes with a visual representation of every months expenses which makes it easy to see the drain holes in your wallet.

## Architecture: MVVM
Expenser uses MVVM architecture along with Rxswift to demostrate how MVVM and observables compliments each other.

## Bindings: RxSwift
[RxSwift](https://github.com/ReactiveX/RxSwift) is used to bind view models, controllers. It keeps the code concise and modular.
As it is event driven, makes it easier to unit test each events.

## Data Layer: Realm
[Realm](https://github.com/realm/realm-cocoa/tree/master/RealmSwift) has been used for data management. Realm provides observable pattern which can easily integrate with RxSwift

## Testing: Quick/Nimble
[Quick/Nimble](https://github.com/Quick/Nimble) has been used for writting test cases.

## Building

### Xcode
Minimum Xcode requirement is Xcode 13. As application uses SF symbols and they are available in xcode 13

### Dependencies
Application uses cocoapods dependencies management. If you dont have cocoapods installed refer to [Installation guide](https://guides.cocoapods.org/using/getting-started.html#installation)