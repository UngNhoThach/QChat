import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:qchat/constants/imagesString.dart';
import 'package:qchat/features/widgets/sizeBox.dart';
import '../../../main.dart';
import '../../widgets/button.dart';
import '../../widgets/textFild.dart';
import '../../widgets/square.dart';
import '../../../../constants/textString.dart';
import 'login.dart';
import 'loginphone.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

  // text editing controllers
  final fullNameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool valueCheckBox = false;

  double _sigmaX = 5; // from 0-10
  double _sigmaY = 5; // from 0-10
  final _formKey = GlobalKey<FormState>();

  // sign user in method
  void signUserIn() {
    if (_formKey.currentState!.validate()) {
      print('valid');
    } else {
      print('not valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizeBoxLine(height: 0.03.h),
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      height: md.height * .07,
                      width: md.height * .7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Create your account",
                              style: textString.heading1),
                        ],
                      ),
                    ),
                    Container(
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: _sigmaX, sigmaY: _sigmaY),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Form(
                              key: _formKey,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    const SizedBox(height: 30),
                                    MyTextField(
                                      controller: fullNameController,
                                      hintText: 'Phone Number',
                                      obscureText: false,
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return 'cannot be empty';
                                        }
                                        return null;
                                      },
                                      onSaved: (String? newValue) {},
                                    ),
                                    sizeBoxLine(height: 0.03.h),
                                    MyTextField(
                                      controller: usernameController,
                                      hintText: 'Password',
                                      obscureText: false,
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return 'cannot be empty';
                                        }
                                        return null;
                                      },
                                      onSaved: (String? newValue) {},
                                    ),
                                    sizeBoxLine(height: 0.03.h),
                                    // MyPasswordTextField(
                                    //   controller: passwordController,
                                    //   hintText: 'Password',
                                    //   obscureText: true,
                                    // ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        MyButtonAgree(
                                          text: "Sign up",
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
                                          style: textString.text_Button,
                                        ),
                                        sizeBoxLine(height: 0.03.h),
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
                                                'Or continue with',
                                                style: textString.text_caption,
                                              ),
                                            ),
                                            Expanded(
                                              child: Divider(
                                                thickness: 2.5,
                                                color: Color.fromARGB(
                                                    255, 202, 171, 171),
                                              ),
                                            ),
                                          ],
                                        ),
                                        sizeBoxLine(height: 0.03.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SquareTile_small(
                                              imagePath: imgChrome,
                                            ),
                                            SquareTile_small(
                                              imagePath: imgApple,
                                            ),
                                            SquareTile_small(
                                              imagePath: imgFb,
                                            )
                                          ],
                                        ),
                                        sizeBoxLine(height: 0.03.h),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                // ignore: prefer_const_literals_to_create_immutables
                                                children: [
                                                  Text(
                                                    'Already have an account?',
                                                    style:
                                                        textString.text_caption,
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  sizeBoxLine(height: 0.015),
                                                  GestureDetector(
                                                    onTap: () {
                                                      // Perform navigation logic here
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                LoginPage()),
                                                      );
                                                    },
                                                    child: Text(
                                                      'Sign in',
                                                      style:
                                                          textString.text_link,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
