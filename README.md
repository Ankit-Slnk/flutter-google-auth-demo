# Flutter User Authentication using Google Demo

![Flutter User Authentication using Google Demo](flutter_google_auth.png)

This demo will show us how to authenticate a user by using google.

![Flutter User Authentication using Google Demo](flutter_google_auth.gif)

## Setup

Use latest versions of below mentioned plugins in `pubspec.yaml`.

| Plugin | Pub | Explanation |
|--------|-----|-------------|
| [connectivity](https://github.com/flutter/plugins/tree/master/packages/connectivity/connectivity) | [![pub package](https://img.shields.io/pub/v/connectivity.svg)](https://pub.dev/packages/connectivity) | Used to check internet connectivity. 
| [google_sign_in](https://github.com/flutter/plugins) | [![pub package](https://img.shields.io/pub/v/google_sign_in.svg)](https://pub.dev/packages/google_sign_in) | Used to authenticate user using google.
| [shared_preferences](https://github.com/PonnamKarthik/shared_preferences) | [![pub package](https://img.shields.io/pub/v/shared_preferences.svg)](https://pub.dev/packages/shared_preferences) | Used to store data locally in key-value pairs.
| [fluttertoast](https://github.com/PonnamKarthik/FlutterToast) | [![pub package](https://img.shields.io/pub/v/fluttertoast.svg)](https://pub.dev/packages/fluttertoast) | Used to show toast.

And then

    flutter pub get

Visit [Firebase Console](https://console.firebase.google.com/u/0/?pli=1) to add new project. Add `Android` and `iOS` app to that project. Add `google-services.json` and `GoogleService-Info.plist` for `Android` and `iOS` respetively to its predefined place in flutter project.

Now enable `Google` Sign-in method (second tab) in Authentication. 

You can also get this steps in Firebase docs for [Android](https://firebase.google.com/docs/auth/android/google-signin) and [iOS](https://firebase.google.com/docs/auth/ios/google-signin).

#### For Android

    <uses-permission android:name="android.permission.INTERNET" />

Please mention `internet` permission in `AndroidManifest.xml`. This will not affect in `debug` mode but in `release` mode it will give `socket exception`.

Add SHA-1 in firebase app 

    1. Open app in Android Studio
    2. Open Gradle panel
    3. Goto andoid -> app -> Tasks -> android
    4. Double click on signingReport, it will generate SHA-1

Add below line in android/build.gradle

    buildscript {
        // ...
        dependencies {
            // ...
            classpath 'com.google.gms:google-services:4.3.2'
        }
    }

Add below line in app/build.gradle

    apply plugin: 'com.android.application'

    android {
        // ...
    }

    dependencies {
        // ...
    }

    // ADD THIS AT THE BOTTOM
    apply plugin: 'com.google.gms.google-services'

#### For iOS

Follow the steps in [google_sign_in](https://pub.dev/packages/google_sign_in) library

#### For Web

Add Firebase core JS SDK

    <script src="https://www.gstatic.com/firebasejs/7.14.3/firebase-app.js"></script>

Add Firebase Auth and Analytics JS for google sign-in

    <script src="https://www.gstatic.com/firebasejs/7.14.3/firebase-auth.js"></script>
    <script src="https://www.gstatic.com/firebasejs/8.0.0/firebase-analytics.js"></script>

Initialize Firebase with configuration

    <script>
    var firebaseConfig = {
      // ... your web apps configuration. This is available in your Firebase project settings.
    };

    // Initialize Firebase
    firebase.initializeApp(firebaseConfig);
    firebase.analytics();
    </script>

Add your web apps client id

    <meta name="google-signin-client_id" content="YOUR_CLIENT_ID.apps.googleusercontent.com">

Replace `YOUR_CLIENT_ID` with client id you get from [Firebase console](https://console.firebase.google.com) 

    Select Project -> Authentication -> Sign-in method -> Google -> Web SDK configuration -> Web client ID

Whitelist the origin of your project's client ID at [Google Console](https://console.developers.google.com/)

    Credentials -> OAuth 2.0 Client IDs
    Click on Web Client

    Add http://localhost:7357 in URIs in Authorized JavaScript origin

    Add http://localhost:7357/auth/google/callback in URIs in Authorized redirect URIs

7357 is port number

Make sure you disable all ad blocker.

### Check Internet Connectivity

    static Future<bool> checkInternet() async {
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.none) {
            return false;
        } else {
            return true;
        }
    }

### Sign-in

    GoogleSignIn().signIn();

### Sign-out

    GoogleSignIn().signOut();

Finally for android and ios

    flutter run

for web

    flutter run -d chrome --web-hostname localhost --web-port 7357

<!-- ##### Please refer to my [blogs](https://ankitsolanki.netlify.app/blog.html) for more information. -->

Checkout [this demo](https://flutter-web-google-auth.netlify.app/#/) in [Flutter Web](https://flutter.dev/docs/get-started/web).