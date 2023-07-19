# Fuse Wallet

The Fuse Wallet is a cross platform Ethereum wallet written in Dart and built on [Flutter](https://flutter.dev/). It's runninng on the Fuse network, but can be plugged into any EVM compatible blockchain.

# Architecture

The Fuse Wallet built upon the [wallet-core SDK](https://github.com/fuseio/wallet_core), which provides a set of API's for the Fuse platform and its auxiliary services. Those services include:
- The Fuse Network and the networks' smart contracts, via the [web3dart](https://github.com/simolus3/web3dart) package
- The [graphql API](https://graph.fuse.io/subgraphs/name/fuseio/fuse/graphql) (provided by [theraph's node](https://thegraph.com/)) provides a convenient API for reading from the network. More info about the API can be found [here](https://github.com/fuseio/fuse-graph)
- The relayer service for fee abstraction
- The [fuse-studio](https://github.com/fuseio/fuse-studio) backend API for business logic and data
- Redux for state management (https://pub.dev/packages/flutter_redux)
- Dio for fetching APIs (https://pub.dev/packages/dio)
- GetIt/Injectable for Dependecy Injection (DI) (https://pub.dev/packages/get_It and https://pub.dev/packages/injectable)
- auto_route for routing (https://pub.dev/packages/auto_route)
- Multi language support (i18n)(https://marketplace.visualstudio.com/items?itemName=localizely.flutter-intl)
- Logging using [logger](https://pub.dev/packages/logger "logger") (lib/utils/log)

## Smart Contracts

We developed and deployed a set of smart contracts, which the wallet interacts with:
- To avoid developing our own best practices and try to adhere to the indusry standarts we used [Argent-contracts](https://github.com/fuseio/argent-contracts), that were taken from the popular [wallet](https://www.argent.xyz/). These contracts are the core of wallet's logic on the Network. Using them, our users are sending free transactions (fee abstraction), have rate limits, and can use wallet recovery. More interesting features will be developed on their basis.
- [Token contracts](https://github.com/fuseio/fuse-studio/tree/master/contracts/token-factory) complying to ERC20 standard
- [Community contracts](https://github.com/fuseio/fuse-studio/tree/master/contracts/entities) to create a tied in interaction between users, businesses and other entities.

## Download the App

You can download the beta version of our app from the [Google Play](https://play.google.com/store/apps/details?id=com.vegiapp.vegi&hl=en) or the [App Store](https://apps.apple.com/us/app/fuse-wallet/id1491783654?ls=1)

## Getting Started

## As a developer
- Set up a Flutter environment on your machine.
   - [You can get started here](https://flutter.dev/docs/get-started/install).
   - Make sure to also [create a keystore as described here](https://flutter.dev/docs/deployment/android).
- Connect a phone or run a simulator.
- Clone the project.

      git clone https://github.com/fuseio/fuse-wallet.git
      cd fuse-wallet

### Configuring the environment

1. Make a copy of `.env_example` named `.env` - `cd environment && cp .env_example .env`

- For Android development, create a file at `./android/key.properties`, [as described here](https://flutter.dev/docs/deployment/android), containing the keystore path and passwords, as set up earlier.
- Run the app.

      flutter run

### Configure firebase:
- `flutterfire logout  # refresh OAuth Token`
- `flutterfire login`
- `dart pub global activate flutterfire_cli`
- `flutterfire configure --project=vegiliverpool  #follow the cli instructions`
This generates the firebase default-options firebase-options.dart file.

[After this initial running of flutterfire configure, you need to re-run the command any time that you:
Start supporting a new platform in your Flutter app.
Start using a new Firebase service or product in your Flutter app, especially if you start using sign-in with Google, Crashlytics, Performance Monitoring, or Realtime Database.
Re-running the command ensures that your Flutter app's Firebase configuration is up-to-date and (for Android) automatically adds any required Gradle plugins to your app.](https://firebase.google.com/docs/flutter/setup?platform=ios#:~:text=After%20this%20initial,to%20your%20app.)

Try out an example app with Analytics
Like all packages, the firebase_analytics plugin comes with an example program.

Open a Flutter app that you've already configured to use Firebase (see instructions on this page).

Access the lib directory of the app, then delete the existing main.dart file.

From the Google Analytics [example program repository](https://github.com/firebase/flutterfire/tree/master/packages/firebase_analytics/firebase_analytics/example/lib), copy-paste the following two files into your app's lib directory:

main.dart
tabs_page.dart
Run your Flutter app.

Go to your app's Firebase project in the Firebase console, then click Analytics in the left-nav.

Click [Dashboard](https://support.google.com/firebase/answer/6317517). If Analytics is working properly, the dashboard shows an active user in the "Users active in the last 30 minutes" panel (this might take time to populate this panel).

Click [DebugView](https://firebase.google.com/docs/analytics/debugview). Enable the feature to see all the events generated by the example program.

For more information about setting up Analytics, visit the getting started guides for iOS+, Android, and web.

Find additional configuration steps for apple IOS APN stuff [here](https://www.notion.so/gember/Firebase-Add-Firebase-to-Flutter-App-67f42bd125034d22acdcf77bc476ae59?pvs=4#6527b2e8b6bc43beb9ac4fd1bb985a2c) (*May need to contact Joey D for access*)

# Testing
First, ensure the firebase project is initialied by checking that there is a firebase.json file at root and if not by running:
```shell
firebase init
```

To run the app tests, you need to configure the firebase emulator and then run it on the port configured in your .env_test file using:
```shell
firebase emulators:start
```
This should show you ports and if you go to the localhost webserver on 4000, you should see:
![https://firebase.google.com/static/codelabs/get-started-firebase-emulators-and-flutter/img/11563f4c7216de81_1920.png]


See docs for the FirebaseAuth Emulator [here](https://firebase.google.com/codelabs/get-started-firebase-emulators-and-flutter#4)

### Saving and Importing Emulator State between Sessions
[Docs](https://firebase.google.com/codelabs/get-started-firebase-emulators-and-flutter#6)

Export:
```shell
firebase emulators:export ./emulators_data
```

Import emulator data:
```shell
firebase emulators:start --import ./emulators_data
```
Export data automatically when closing emulators:
```shell
firebase emulators:start --import ./emulators_data --export-on-exit
```

## Apple Pay Certificates & Stripe
See docs [here](https://www.notion.so/gember/Firebase-Add-Firebase-to-Flutter-App-67f42bd125034d22acdcf77bc476ae59?pvs=4#56afaf0ec85d43b290e067394b80e6ce)

### Messaging templates
Firebase messaging templates i.e. [email templates](https://console.firebase.google.com/u/0/project/vegiliverpool/authentication/emails) can be configured in the [Authentication](https://console.firebase.google.com/u/0/project/vegiliverpool/authentication/emails) tab on the firebase console for [vegiliverpool](https://console.firebase.google.com/u/0/project/vegiliverpool/overview).

## As an enterprenuer or a community manager
Launch your community on the [Fuse Studio](https://studio.fuse.io/), then open the community dashboard. There you can configure it and *customize your wallet* app. When you done go to "White label wallet" and send an app invite link to yourself. Visit our [docs](https://docs.fuse.io/the-fuse-studio/overview) to learn about the Fuse Studio.

## Google api keys:
Google api keys need to be configures for places and distances apis. These are bundle id specific and need to be configured in the [credentials](https://developers.google.com/maps/documentation/distance-matrix/get-api-key)