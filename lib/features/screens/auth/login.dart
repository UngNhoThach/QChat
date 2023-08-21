// import 'package:qchat/constants/colors.dart';
// import 'package:qchat/features/screens/auth/re_password.dart';
// import 'package:qchat/features/screens/auth/signup.dart';

// import '../../widgets/dialogs.dart';
// import 'dart:developer' as developer;
// import 'dart:ui';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:qchat/provider/auth_provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:qchat/constants/textString.dart';
// import 'package:qchat/main.dart';
// import '../../widgets/button.dart';
// import '../../widgets/checkbox.dart';
// import '../../widgets/sizeBox.dart';
// import '../../widgets/square.dart';
// import '../../widgets/textFild.dart';
// import '../../../../constants/imagesString.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   // text editing controllers
//   final _passwordController = TextEditingController();
//   final _emailController = TextEditingController();
//   double _sigmaX = 5; // from 0-10
//   double _sigmaY = 5; // from 0-10
//   final _formKey = GlobalKey<FormState>();

//   bool passwordVisible = false;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     passwordVisible = true;
//     //hide or show password
//   }

//   // sign user in method
//   void signUserIn() {
//     if (_formKey.currentState!.validate()) {
//       print('valid');
//     } else {
//       print('not valid');
//     }
//   }

//   _handleGoogleBtnClick() {
//     // showing progress bar
//     dialogs.showProcessBar(context);

//     _signInWithGoogle().then((user) {
//       if (user != null) {
//         // hiding progress bar
//         Navigator.pop(context);
//         developer.log('User: ${user.user}');
//         developer.log('UserAddtionalInfo: ${user.additionalUserInfo}');
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (_) => LoginPage()));
//       }
//     });
//   }

//   Future<UserCredential?> _signInWithGoogle() async {
//     try {
//       // check internet
//       await InternetAddress.lookup('google.com');

//       // Trigger the authentication flow
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//       // Obtain the auth details from the request
//       final GoogleSignInAuthentication? googleAuth =
//           await googleUser?.authentication;

//       // Create a new credential
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken,
//         idToken: googleAuth?.idToken,
//       );

//       // singn in the user with UserCredentials
//       return await AuthProvider.auth.signInWithCredential(credential);
//       // final UserCredential userCredential =
//       //     await auth.signInWithCredential(credential);
//     } catch (e) {
//       developer.log('\n_signInWithGoogle: $e');
//       dialogs.showSnackBar(context, 'Check your internet!');
//       return null;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     md = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       body: SingleChildScrollView(
//         child: Container(
//           height: MediaQuery.of(context).size.height,
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   sizeBoxLine(height: 0.03.h),
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back_ios),
//                     color: Colors.white,
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   Container(
//                     height: MediaQuery.of(context).size.height * 20 / 100,
//                     width: MediaQuery.of(context).size.width * 100 / 100,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text("Log in", style: textString.heading1),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     child: ClipRect(
//                       child: BackdropFilter(
//                         filter:
//                             ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
//                         child: Container(
//                           padding: EdgeInsets.symmetric(horizontal: 8),
//                           child: Form(
//                             key: _formKey,
//                             child: Center(
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 25.0),
//                                     child: Row(children: []),
//                                   ),
//                                   MyTextField(
//                                     controller: _emailController,
//                                     hintText: 'Email',
//                                     obscureText: false,
//                                     validator: (String? value) {
//                                       if (value == null || value.isEmpty) {
//                                         return 'cannot be empty';
//                                       }
//                                       return null;
//                                     },
//                                     onSaved: (String? newValue) {},
//                                   ),
//                                   sizeBoxLine(height: 0.015.h),
//                                   MyPasswordTextField(
//                                     controller: _passwordController,
//                                     hintText: 'Password',
//                                     obscureText: passwordVisible,
//                                     onpress: () {
//                                       setState(() {
//                                         passwordVisible = !passwordVisible;
//                                       });
//                                     },
//                                   ),
//                                   sizeBoxLine(height: 0.015.h),
//                                   PasswordCheckBox(
//                                     labelText: 'Remember me',
//                                     onChanged: (value) => CheckboxListTile,
//                                   ),
//                                   MyButtonNotIcon(
//                                     height: md.height * .07,
//                                     width: md.height * .7,
//                                     text: "Sign in with password",
//                                     style: textString.text_Button,
//                                     onTap: (() {
//                                       if (_formKey.currentState!.validate()) {
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     LoginPage()));
//                                       } else {
//                                         print('not valid');
//                                       }
//                                     }),
//                                     color: colors.main_color,
//                                   ),
//                                   sizeBoxLine(height: 0.015.h),
//                                   GestureDetector(
//                                       onTap: () => Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     re_passWord()),
//                                           ),
//                                       child: Text(
//                                         'Forgot Password?',
//                                         style: textString.text_link,
//                                       )),
//                                   sizeBoxLine(height: 0.015.h),
//                                   Row(
//                                     children: [
//                                       Expanded(
//                                         child: Divider(
//                                           thickness: 2.5,
//                                           color: Colors.grey[400],
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 10.0),
//                                         child: Text(
//                                           'Or continue with',
//                                           style: textString.text_caption,
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: Divider(
//                                           thickness: 2.5,
//                                           color: Color.fromARGB(
//                                               255, 202, 171, 171),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   sizeBoxLine(height: 0.015),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       SquareTile_small(
//                                         imagePath: imgChrome,
//                                       ),
//                                       SquareTile_small(
//                                         imagePath: imgApple,
//                                       ),
//                                       SquareTile_small(
//                                         imagePath: imgFb,
//                                       ),
//                                     ],
//                                   ),
//                                   sizeBoxLine(height: 0.015),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.stretch,
//                                       children: [
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           // ignore: prefer_const_literals_to_create_immutables
//                                           children: [
//                                             Text(
//                                               'Don\'t have an account?',
//                                               style: textString.text_caption,
//                                               textAlign: TextAlign.start,
//                                             ),
//                                             const SizedBox(width: 10),
//                                             GestureDetector(
//                                               onTap: () {
//                                                 // Perform navigation logic here
//                                                 Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           Signup()),
//                                                 );
//                                               },
//                                               child: Text(
//                                                 'Sign Up',
//                                                 style: textString.text_link,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
