import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qchat/provider/auth_provider.dart';

import '../../../../constants/imagesString.dart';
import '../../widgets/nextscreen.dart';
import '../home_Screen.dart';

// splash screen
class snappScreen extends StatefulWidget {
  snappScreen({super.key});
  @override
  State<snappScreen> createState() => _snappScreen();
}

class _snappScreen extends State<snappScreen> {
  // check user

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      //exit full-screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

      if (AuthProvider.auth.currentUser != null) {
        //navigate to homeScreen screen
        nextScreenRe(context, homeScreen());
      } else {
        //navigate to onBoading
        nextScreenRe(context, homeScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body
      body: Stack(children: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //app logo
              Image.asset(splashImage),

              // google login button

              Text('MADE IN NTHACH WITH ❤️'),
            ]),
      ]),
    );
  }
}
