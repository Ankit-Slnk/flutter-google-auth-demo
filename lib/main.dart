import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googleauth/screens/googleLoginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //most important thing is to initialise firebase in project
  // await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(MyApp());
    },
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: GoogleAuthScreen(),
      ),
    );
  }
}
