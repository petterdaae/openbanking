# Open Banking
![](https://img.shields.io/badge/built%20with-firebase-orange.svg) ![](https://img.shields.io/badge/built%20with-flutter-blue.svg) ![](https://img.shields.io/badge/PRs-welcome-green.svg)

## 🛠️ Development setup
* Install [flutter](https://flutter.dev/docs/get-started/install).
* Install the [firebase cli](https://firebase.google.com/docs/cli).
* Set up your own firebase project. You can do this in the [firebase console](https://console.firebase.com).
* Deploy cloud functions and security rules to the firebase project.
* Setup an emulator. Both Android and iOS will do. You can create Android emulators in [android studio](https://developer.android.com/studio). You can also use a physical device if you want to.
* Add firebase to [Android](https://firebase.google.com/docs/android/setup) (*Option 1*) or [iOS](https://firebase.google.com/docs/ios/setup).
* Start your emulator or connect your physical device.
* Run `flutter run` in `app/`.

## Goals
* [x] Show accounts
* [x] Show transactions
* [x] Categorize transactions 
* [x] Get an overview of spendings (based on categories)
* [ ] Create multilevel categories
* [ ] Split transactions
* [ ] Add expected incomes and expenses 
* [ ] Show status on future economy
* [ ] Automaitcally categorize transactions
* [ ] Transfer between accounts

## Problems
* [ ] At this point in time it is clumsy to determine the uniqueness of transactions from Sbanken. Therefore, the uniqueness is currently determined by the transaction date and amount.

