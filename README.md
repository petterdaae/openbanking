# Open Banking

![flutter analyze](https://github.com/petterdaae/openbanking/workflows/flutter%20analyze/badge.svg?branch=master)

## 🛠️ Development setup
* Install [flutter](https://flutter.dev/docs/get-started/install).
* Install the [firebase cli](https://firebase.google.com/docs/cli).
* Set up your own firebase project. You can do this in the [firebase console](https://console.firebase.com).
    * Create a firestore database.
    * Enable email/password authentication.
    * Deploy cloud functions and security rules to the firebase project.
    * Register the app in firebase ([Android](https://firebase.google.com/docs/android/setup) (*Option 1*) or [iOS](https://firebase.google.com/docs/ios/setup)).
* Setup an emulator. Both Android and iOS will do. You can create Android emulators in [android studio](https://developer.android.com/studio). You can also use a physical device if you want to.
* Start your emulator or connect your physical device.
* Run `flutter run` in `app/`.

### Creating new users
* Create the user in authentication (submit an email and a password).
* Create a docuement for that user in the *users* collection in firestore.
* The id of the document should be the same as the user id.
* The document should look something like the json below:
```json
{
    "name": "Ola Nordman",
    "nationalid": "99999999999",
    "sbanken_clientid": "id",
    "sbanken_clientsecret": "secret"
}
```

## 🥅  Goals
* [x] Show accounts
* [x] Show transactions
* [x] Categorize transactions 
* [x] Get an overview of spendings (based on categories)
* [ ] Add expected incomes and expenses 
* [ ] Automaitcally categorize transactions
* [ ] Split transactions
* [ ] Create multilevel categories
* [ ] Transfer between accounts
* [ ] Show status on future economy

## ❌  Problems
* [ ] At this point in time it is clumsy to determine the uniqueness of transactions from Sbanken. Therefore, the uniqueness is currently determined by the transaction date and amount. If there are several transactions with the same date and amount they will be added several times to the databse, but they will all look the same. So, if there exists two transactions with the same date and amount, but different descriptions, only one of them will be added to the database twice.

