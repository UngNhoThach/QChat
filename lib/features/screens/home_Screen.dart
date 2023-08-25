import 'dart:io';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qchat/provider/auth_provider.dart';
import 'package:qchat/constants/colors.dart';
import 'package:qchat/constants/imagesString.dart';
import 'package:qchat/constants/textString.dart';
import '../widgets/nextscreen.dart';
import '../widgets/sizeBox.dart';
import '../widgets/square.dart';
import '../widgets/button.dart';
import '../../../../main.dart';
import 'auth/loginphone.dart';
import 'auth/signup.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../widgets/dialogs.dart';
import 'dart:developer' as developer;
import 'auth/chat_home.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});
  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  void initState() {
    super.initState();
  }

  _handleGoogleBtnClick() {
    // showing progress bar
    dialogs.showProcessBar(context);

    _signInWithGoogle().then((user) async {
      if (user != null) {
        // hiding progress bar
        Navigator.pop(context);
        if (await AuthProvider.userExists()) {
          nextScreenRe(context, chatHome());
        } else {
          await AuthProvider.userCreate().then((user) {
            // developer.log('User: ${user.user}');
            // developer.log('UserAddtionalInfo: ${user.additionalUserInfo}');
            nextScreenRe(context, chatHome());
          });
        }
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      // check internet
      await InternetAddress.lookup('google.com');

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // singn in the user with UserCredentials
      // return await API.auth.signInWithCredential(credential);
      final UserCredential userCredential =
          await AuthProvider.auth.signInWithCredential(credential);
      return userCredential;
    } catch (e) {
      developer.log('\n_signInWithGoogle: $e');
      dialogs.showSnackBar(context, 'Check your internet!');
      return null;
    }
  }

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  double _sigmaX = 5; // from 0-10
  double _sigmaY = 5; // from 0-10

  final _formKey = GlobalKey<FormState>();

  // sign user in method
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    md = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sizeBoxLine(height: 0.02.h),
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 20 / 100,
                    width: MediaQuery.of(context).size.width * 100 / 100,
                    child: Row(
                      children: [],
                    ),
                  ),
                  Container(
                    child: ClipRect(
                      child: BackdropFilter(
                        filter:
                            ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                        child: Container(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // or continue with
                                // google + apple sign in buttons
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // facebook button
                                      SquareTile(
                                        onTap: () => () {},
                                        imagePath: imgFb,
                                        title: "Continue with Facebook",
                                        style: textString.text_Button_BL,
                                      ),
                                      sizeBoxLine(height: 0.02.h),

                                      // google button
                                      SquareTile(
                                        onTap: () => _handleGoogleBtnClick(),
                                        imagePath: imgChrome,
                                        title: "Continue with Google",
                                        style: textString.text_Button_BL,
                                      ),
                                      sizeBoxLine(height: 0.02.h),

                                      // apple button
                                      SquareTile(
                                        onTap: () => {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => LoginPage())),
                                        },
                                        imagePath: imgApple,
                                        title: "Continue with Apple",
                                        style: textString.text_Button_BL,
                                      ),
                                    ],
                                  ),
                                ),
                                sizeBoxLine(height: 0.015.h),

                                Row(
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        thickness: 2.5,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                        'Or',
                                        style: textString.text_caption,
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        thickness: 2.5,
                                        color:
                                            Color.fromARGB(255, 202, 171, 171),
                                      ),
                                    ),
                                  ],
                                ),
                                sizeBoxLine(height: 0.015.h),

                                // sign in button
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    children: [
                                      MyButton(
                                        height: md.height * .07,
                                        width: md.height * .7,
                                        style: textString.text_Button,
                                        text: 'Login phone number',
                                        onTap: (() {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginPage()),
                                            );
                                          } else {
                                            print('not valid');
                                          }
                                        }),
                                        color: colors.main_color,
                                        icon: Icons.login_rounded,
                                        border: 25,
                                      ),
                                    ],
                                  ),
                                ),

                                sizeBoxLine(height: 0.02.h),
                                // not a member? register now
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          Text(
                                            'Don\'t have an account?',
                                            style: textString.text_caption,
                                            textAlign: TextAlign.start,
                                          ),
                                          const SizedBox(width: 10),
                                          GestureDetector(
                                            onTap: () {
                                              // Perform navigation logic here
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Signup()),
                                              );
                                            },
                                            child: Text(
                                              'Sign Up',
                                              style: textString.text_link,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
