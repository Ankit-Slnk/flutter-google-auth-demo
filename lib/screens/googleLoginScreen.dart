import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleauth/utility/appAssets.dart';
import 'package:googleauth/utility/appColors.dart';
import 'package:googleauth/utility/utility.dart';
import 'package:googleauth/utility/appStrings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleAuthScreen extends StatefulWidget {
  @override
  _GoogleAuthScreenState createState() => _GoogleAuthScreenState();
}

class _GoogleAuthScreenState extends State<GoogleAuthScreen> {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  SharedPreferences pref;
  String photoUrl;
  String name;
  String email;

  getPref() async {
    pref = await SharedPreferences.getInstance();
    photoUrl = pref.getString(AppStrings.PHOTO_URL_PREFERENCE);
    name = pref.getString(AppStrings.NAME_PREFERENCE);
    email = pref.getString(AppStrings.EMAIL_PREFERENCE);
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Utility.imageLoader(
                        photoUrl == null ? "" : photoUrl,
                        AppAssets.placeHolder,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    name == null ? "Guest User" : name,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    email == null ? "" : email,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.center,
              child: RaisedButton(
                color: AppColors.appColor,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 16,
                  ),
                  child: Text(
                    email == null && name == null && photoUrl == null
                        ? "Login"
                        : "Logout",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
                onPressed: () {
                  if (email == null && name == null && photoUrl == null) {
                    __googleSignIn();
                  } else {
                    _googleSignOut();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  __googleSignIn() async {
    try {
      if (await Utility.checkInternet()) {
        _googleSignIn.signIn().then((onValue1) async {
          await pref.setString(
              AppStrings.NAME_PREFERENCE, onValue1.displayName);
          await pref.setString(AppStrings.EMAIL_PREFERENCE, onValue1.email);
          await pref.setString(
              AppStrings.PHOTO_URL_PREFERENCE, onValue1.photoUrl);
          getPref();
          onValue1.authentication.then((onValue2) {
            // for token
          });
        });
      } else {
        Fluttertoast.showToast(msg: "No internet connection");
      }
    } catch (error) {
      print(error);
    }
  }

  _googleSignOut() async {
    try {
      if (await Utility.checkInternet()) {
        _googleSignIn.signOut().then((value) async {
          await pref.clear();
          getPref();
        });
      } else {
        Fluttertoast.showToast(msg: "No internet connection");
      }
    } catch (e) {}
  }
}
