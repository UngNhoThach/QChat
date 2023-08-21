// ignore_for_file: prefer_const_constructors

import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qchat/features/screens/auth/chat_home.dart';
import 'package:qchat/features/screens/home_Screen.dart';
import 'package:qchat/features/widgets/dialogs.dart';
import 'package:qchat/features/widgets/nextscreen.dart';
import 'package:qchat/provider/auth_provider.dart';
import '../../widgets/sizeBox.dart';
import '../../../../constants/textString.dart';

// ignore: must_be_immutable
class otpScreen extends StatelessWidget {
  late final String verificationID;
  final String phoneNumber;
  otpScreen(
      {super.key, required this.phoneNumber, required this.verificationID});
  @override
  // State<otpScreen> createState() => _otpScreen();

// class _otpScreen extends State<otpScreen> {
  // variables
  int maxAttempts = 3;
  int currentAttempt = 1;
  // bool isVerification = false;

  double _sigmaX = 5; // from 0-10
  double _sigmaY = 5;

  // text editing controllers
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // @override
  // void initState() {
  //   super.initState();
  //   verificationId = widget.verificationID;
  // }

  // void dispose() {
  //   super.dispose();
  // }

  Future<bool> signInWithSmsCode() async {
    var credentials = await AuthProvider.auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationID,
            smsCode: _otpController.text.trim()));
    // smsCode: _otpController.text.trim()));
    return credentials.user != null ? true : false;
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
                    sizeBoxLine(height: 0.02.h),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    ClipRect(
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
                                    height: 150,
                                  ),
                                  Text(
                                    'Verification',
                                    style: textString.heading2,
                                  ),
                                  sizeBoxLine(height: 0.08),
                                  Text(
                                      'Enter the OTP send to your phone number'),
                                  sizeBoxLine(height: 0.03),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: <Widget>[
                                        TextField(
                                          controller: _otpController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            labelText: 'Enter OTP',
                                          ),
                                        ),
                                        // String otp = _otpController.text.trim(),
                                        SizedBox(height: 16),
                                        ElevatedButton(
                                          onPressed: () {
                                            print('${signInWithSmsCode()}');
                                            if (signInWithSmsCode() == true) {
                                              nextScreenRe(context, chatHome());
                                            } else {
                                              // if (currentAttempt <=
                                              //     maxAttempts) {
                                              //   dialogs.showSnackBar(context,
                                              //       "OTP is wrong or not available count login ${currentAttempt}");
                                              //   print(verificationId);
                                              //   // signInWithSmsCode();
                                              //   setState(() {
                                              //     currentAttempt++;
                                              //   });
                                              // } else {
                                              dialogs.showSnackBar(context,
                                                  "OTP is wrong is the last attempt");
                                              // }
                                            }

                                            // Implement the OTP verification here
                                            // You can use 'verificationId' and the entered OTP to create a PhoneAuthCredential
                                            // and then sign in using the credential
                                            // For example:
                                            // PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: enteredOtp);
                                            // await FirebaseAuth.instance.signInWithCredential(credential);
                                          },
                                          child: Text('Verify OTP'),
                                        ),

                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.spaceBetween,
                                        //   children: [
                                        //     OTP(obscureText: true),
                                        //     OTP(obscureText: true),
                                        //     OTP(obscureText: true),
                                        //     OTP(obscureText: true),
                                        //     OTP(obscureText: true),
                                        //     OTP(obscureText: true),
                                        //   ],
                                        // ),
                                        // sizeBoxLine(height: 0.03),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.center,
                                        //   children: [
                                        //     MyButtonNotIcon(
                                        //       border: 10,
                                        //       height: md.height * .07,
                                        //       width: md.height * .3,
                                        //       style: textString.text_Button,
                                        //       text: 'Verify',
                                        //       onTap: (() {
                                        //         // if (_formKey.currentState!
                                        //         //     .validate()) {
                                        //         //   Navigator.push(
                                        //         //     context,
                                        //         //     MaterialPageRoute(
                                        //         //         builder: (context) =>
                                        //         //             dialogs.dialogSuccess()),
                                        //         //   );
                                        //         // } else {
                                        //         //   print('not valid');
                                        //         // }
                                        //       }),
                                        //       color: colors.main_color,
                                        //       // ),
                                        //     ),
                                        //   ],
                                        // )
                                      ],
                                    ),
                                  ),
                                  sizeBoxLine(height: 0.03),
                                  Text("Did't receive any code?"),
                                  // sizeBoxLine(height: 0.03),
                                  // Text("Timed out for code ?"),
                                  sizeBoxLine(height: 0.03),
                                  Text(
                                    "Resend new code",
                                    style: textString.text_link,
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
      ),
    );
  }
}
