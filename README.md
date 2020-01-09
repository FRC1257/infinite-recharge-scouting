# Deep Space Flutter Rebuild

This is the 2019 Flutter rebuild of the 1257 Deep Space scouting app. This is intended as a guide on which future scouting apps should be built; it is being done here in Flutter for iOS and Android compatibility in order to create a fully exportable and versatile scouting system for other teams.

Instructions to Compile
------

To compile for either Android or iOS, install Flutter from [these instructions](https://flutter.io/setup).

### Compiling for Android

Run `flutter build apk` in the repository root to generate the release APK.

### Compiling to iOS

Complete the necessary setup in Xcode (after plugging the intended device into a Mac) in order to run `flutter build ios` in the repository root.

Distribution
------

  * The APK file at `build/app/outputs/apk/release/app-release.apk` can be shared anywhere, through Drive or e-mail.
  * For iOS, compress the generated app into an IPA file. Using a service such as [Diawi](https://diawi.com), it may be possible to distribute said scouting app without necessarily connecting every device to a Mac.

Setup and Use
------

If you want to use this to have a scouting system, you will need 6 devices. Please contact us at scouting1257@gmail.com for us to generate analysis spreadsheets and prefilled form links for data input for you (else the app data will be useless). You will need to: 
  * take the form IDs for the links and put them into the settings under Objective and Pit 
  * change the robot to scout under the settings page for each device to a different robot

The scouting itself is fairly self-explanatory - just fill out the fields and submit.

To send data, you can
  * just submit when scouting if your device has an Internet connection at the time
  * load and upload error logs on the Send screen whenever your device has an internet connection
  * (for Android) run app on BT paired device with a connection and accept connections on that device before sending from Send screen
