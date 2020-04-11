# Open Banking
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)]() 

## Development setup
* Install [flutter](https://flutter.dev/docs/get-started/install).
* Install the [firebase cli](https://firebase.google.com/docs/cli).
* Set up your own firebase project. You can do this in the [firebase console](https://console.firebase.com).
* Setup an emulator. Both Android and iOS will do. You can create Android emulators in [android studio](https://developer.android.com/studio). You can also use a physical device if you want to.
* Add firebase to [Android](https://firebase.google.com/docs/android/setup) or [iOS](https://firebase.google.com/docs/ios/setup).
* Start your emulator or connect your physical device.
* Run `flutter run` in `app/`.

## Goals
* [x] Show accounts
* [x] Show transactions
* [ ] Transfer between accounts
* [ ] Categorize transactions and get an overview of spendings
* [ ] Automaitcally categorize transactions
* [ ] Add expected incomes and expenses and show status on future economy
* [ ] Split transactions

## Problems
### Showing the sum of transactions in a category within a timespan
* *Current solution*: Does not support this (only supports the total). This can be precomputed efficiently using cloud functions.
* *Possible solution*:  Precalculate each month. This can also be implemented efficiently.
* *Possible solution*: Fetch all transactions and compute the sum client-side. This will cause a lot of database reads.

### Inconsistency in transactions
* One transaction appeared twice
* Transaction did'nt have the same date as in the banking app
* Might be mistakes I have made or bugs in the open api
