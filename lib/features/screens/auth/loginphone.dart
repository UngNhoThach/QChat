import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:qchat/constants/colors.dart';
import 'package:qchat/features/screens/auth/otpscreen.dart';
import 'package:qchat/features/screens/auth/re_password.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qchat/constants/textString.dart';
import 'package:qchat/features/widgets/dialogs.dart';
import 'package:qchat/features/widgets/nextscreen.dart';
import 'package:qchat/main.dart';
import '../../../provider/auth_provider.dart';
import '../../widgets/button.dart';
import '../../widgets/sizeBox.dart';
import '../../widgets/square.dart';
import '../../../../constants/imagesString.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

// check is number of strings
bool isNumeric(String str) {
  if (str == null) {
    return false;
  }
  return double.tryParse(str) != null;
}

class _LoginPageState extends State<LoginPage> {
  // variables
  String verificationID = "";
  var phoneOnly = '';
  var phoneNo = '';
  // controllers
  final _phoneController = TextEditingController();

  // vaditor
  final _formKey = GlobalKey<FormState>();

  double _sigmaX = 5; // from 0-10
  double _sigmaY = 5; // from 0-10

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // function to login with phone number
  Future<void> loginwithPhone() async {
    // show progress bar
    dialogs.showProcessBar(context);
    String phoneNumber = phoneNo;
    if (phoneOnly.isNotEmpty) {
      // hiding progress bar
      Navigator.pop(context);
      await AuthProvider.auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: const Duration(seconds: 60),
          verificationCompleted: (PhoneAuthCredential credential) async {
            await AuthProvider.auth
                .signInWithCredential(credential)
                .then((value) {});
          },
          verificationFailed: (FirebaseAuthException e) {
            print(e.message);
          },
          codeSent: (String verificationId, int? resendToken) {
            nextScreenRe(
                context,
                otpScreen(
                    phoneNumber: phoneNumber, verificationID: verificationId));
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
    } else {
      // hiding progress bar
      Navigator.pop(context);
      dialogs.showSnackBar(context, 'Please enter a valid phone number.');
    }
  }

  @override
  Widget build(BuildContext context) {
    md = MediaQuery.of(context).size;

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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Log in", style: textString.heading1),
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
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25.0),
                                      child: Row(children: []),
                                    ),

                                    // fill your phone number

                                    // select country before the phone number
                                    IntlPhoneField(
                                      controller: _phoneController,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(
                                            RegExp(r'\s')),
                                      ],
                                      flagsButtonPadding:
                                          const EdgeInsets.all(8),
                                      dropdownIconPosition:
                                          IconPosition.trailing,
                                      decoration: const InputDecoration(
                                        // labelText: 'Phone Number',
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(),
                                        ),
                                      ),
                                      initialCountryCode: 'VN',
                                      onChanged: (phone) {
                                        phoneNo = phone.completeNumber;
                                        phoneOnly = phone.number;
                                        print(phoneOnly);
                                      },
                                    ),

                                    sizeBoxLine(height: 0.03),
                                    MyButtonNotIcon(
                                      height: md.height * .07,
                                      width: md.height * .7,
                                      text: "Send OTP",
                                      style: textString.text_Button,
                                      onTap: (() {
                                        loginwithPhone();
                                        // nextScreenRe(context, otpScreen());
                                        // if (_formKey.currentState!.validate()) {
                                        //   Navigator.push(
                                        //       context,
                                        //       MaterialPageRoute(
                                        //           builder: (context) =>
                                        //               LoginPage()));
                                        // } else {
                                        //   print('not valid');
                                        // }
                                      }),
                                      color: colors.main_color,
                                      border: 20,
                                    ),
                                    sizeBoxLine(height: 0.03),
                                    GestureDetector(
                                        onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      re_passWord()),
                                            ),
                                        child: Text(
                                          'Forgot Password?',
                                          style: textString.text_link,
                                        )),
                                    sizeBoxLine(height: 0.03),
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
                                    sizeBoxLine(height: 0.03),
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
                                        ),
                                      ],
                                    ),
                                    sizeBoxLine(height: 0.03),
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
                                                'Don\'t have an account?',
                                                style: textString.text_caption,
                                                textAlign: TextAlign.start,
                                              ),
                                              const SizedBox(width: 10),
                                              GestureDetector(
                                                onTap: () {
                                                  // Perform navigation logic here
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
