// // ignore_for_file: prefer_const_constructors

// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:qchat/constants/colors.dart';
// import 'package:qchat/features/screens/auth/otpscreen.dart';
// import '../../../../main.dart';
// import '../../widgets/button.dart';
// import '../../widgets/sizeBox.dart';
// import '../../../../constants/textString.dart';

// // ignore: must_be_immutable
// class new_pin extends StatelessWidget {
//   new_pin({super.key});

//   // text editing controllers
//   final newPinController = TextEditingController();

//   double _sigmaX = 5; // from 0-10
//   double _sigmaY = 5; // from 0-10
//   final _formKey = GlobalKey<FormState>();

//   // sign user in method

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
//                   sizeBoxLine(height: 0.05),
//                   Row(
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.arrow_back_ios),
//                         color: Colors.white,
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                       ),
//                       ClipRect(
//                         child: Center(
//                           child: Text("Create New PIN",
//                               style: textString.text_Button_BL),
//                         ),
//                       ),
//                     ],
//                   ),
//                   ClipRect(
//                     child: BackdropFilter(
//                       filter:
//                           ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
//                       child: Container(
//                         padding: EdgeInsets.symmetric(horizontal: 8),
//                         child: Form(
//                           key: _formKey,
//                           child: Center(
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 25.0),
//                                   child: Row(children: []),
//                                 ),

//                                 SizedBox(
//                                   height: 150,
//                                 ),
//                                 // sizeBoxLine(height: 0.05),
//                                 Text(
//                                     'Add a PIN number to make your account more secure'),
//                                 sizeBoxLine(height: 0.05),

//                                 sizeBoxLine(height: 0.02),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: <Widget>[
//                                     OTP(
//                                       obscureText: true,
//                                     ),
//                                     OTP(
//                                       obscureText: true,
//                                     ),
//                                     OTP(
//                                       obscureText: true,
//                                     ),
//                                     OTP(
//                                       obscureText: true,
//                                     ),
//                                   ],
//                                 ),
//                                 sizeBoxLine(height: 0.05),
//                                 MyButton(
//                                   style: textString.text_Button,
//                                   text: 'Continue',
//                                   onTap: (() {
//                                     if (_formKey.currentState!.validate()) {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) => otpScreen()),
//                                       );
//                                     } else {
//                                       print('not valid');
//                                     }
//                                   }),
//                                   color: colors.main_color.withOpacity(0.8),
//                                   icon: null,
//                                   height: md.height * .1,
//                                   width: md.height * .7,
//                                   border: 25,
//                                 ),
//                               ],
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
