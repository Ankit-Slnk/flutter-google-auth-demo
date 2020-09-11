import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
              child: email == null && name == null && photoUrl == null
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            photoUrl,
                            height: 90,
                            width: 90,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          email,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.center,
              child: RaisedButton(
                child: Text(
                  email == null && name == null && photoUrl == null
                      ? "Login"
                      : "Logout",
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

  __googleSignIn() {
    try {
      _googleSignIn.signIn().then((onValue1) async {
        await pref.setString(AppStrings.NAME_PREFERENCE, onValue1.displayName);
        await pref.setString(AppStrings.EMAIL_PREFERENCE, onValue1.email);
        await pref.setString(
            AppStrings.PHOTO_URL_PREFERENCE, onValue1.photoUrl);
        getPref();
        onValue1.authentication.then((onValue2) {
          // for token
        });
      });
    } catch (error) {
      print(error);
    }
  }

  _googleSignOut() {
    try {
      _googleSignIn.signOut().then((value) async {
        await pref.clear();
        getPref();
      });
    } catch (e) {}
  }
}
