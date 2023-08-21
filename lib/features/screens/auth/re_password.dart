// ignore_for_file: prefer_const_constructors

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qchat/constants/colors.dart';
import 'package:qchat/features/screens/auth/otpscreen.dart';
import 'package:qchat/features/widgets/nextscreen.dart';
import '../../../../main.dart';
import '../../widgets/button.dart';
import '../../widgets/sizeBox.dart';
import '../../widgets/square.dart';
import '../../../../constants/textString.dart';

// ignore: must_be_immutable
class re_passWord extends StatelessWidget {
  re_passWord({super.key});

  // text editing controllers
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  double _sigmaX = 5; // from 0-10
  double _sigmaY = 5; // from 0-10
  final _formKey = GlobalKey<FormState>();
  String _name = 'NThach';

  // sign user in method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text("Forgot Password", style: textString.text_Button_BL),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 20 / 100,
                    width: MediaQuery.of(context).size.width * 100 / 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [],
                    ),
                  ),
                  Container(
                    child: ClipRect(
                      child: BackdropFilter(
                        filter:
                            ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Form(
                            key: _formKey,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25.0),
                                    child: Row(children: []),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15),
                                  Text(
                                    'Hello, $_name! Please select which contact detail should we use to reset your password',
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: textString.text_Body,
                                  ),
                                  sizeBoxLine(height: 0.015),
                                  Square_item(
                                      icon: Icons.sms,
                                      detail: 'and ungnhothach.2001@gmail.com ',
                                      title: 'via Email'),
                                  sizeBoxLine(height: 0.015.h),
                                  Square_item(
                                      icon: Icons.email,
                                      detail: 'and ungnhothach.2001@gmail.com',
                                      title: 'via Email'),
                                  sizeBoxLine(height: 0.015.h),
                                  MyButton(
                                    height: md.height * .1,
                                    width: md.height * .7,
                                    style: textString.text_Button,
                                    text: 'Continue',
                                    onTap: (() {
                                      // nextScreen(context, otpScreen());
                                      // if (_formKey.currentState!.validate()) {
                                      //   Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             chat_profile_screen()),
                                      //   );
                                      // } else {
                                      //   print('not valid');
                                      // }
                                    }),
                                    color: colors.main_color,
                                    icon: null,
                                    border: 25,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
