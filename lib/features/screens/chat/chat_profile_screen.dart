import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:qchat/constants/colors.dart';
import 'package:qchat/features/widgets/dialogs.dart';
import 'package:qchat/main.dart';
import 'package:qchat/provider/auth_provider.dart';
import '../../models/chat_user_model.dart';
import '../../widgets/button.dart';
import '../../widgets/nextscreen.dart';
import '../../widgets/sizeBox.dart';
import '../../widgets/square.dart';
import '../../../../constants/textString.dart';
import '../../widgets/textFild.dart';
import '../home_Screen.dart';
import 'package:image_picker/image_picker.dart';

class chat_profile_screen extends StatefulWidget {
  final chatUserModel userModel;

  const chat_profile_screen({super.key, required this.userModel});

  @override
  State<chat_profile_screen> createState() => _chat_profile_screenState();
}

class _chat_profile_screenState extends State<chat_profile_screen> {
  @override
  void initState() {
    super.initState();
    _dateinput.text = widget.userModel.dateOfBirth.toString();
  }

  // control widgets
  final _formKey = GlobalKey<FormState>();

  //variables
  String? birthDateInString;
  // late DateTime birthDate;
  String? phone;
  String? imgPath;

  // text editing controllers
  final AboutController = TextEditingController();
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final _dateinput = TextEditingController();

  double _sigmaX = 5; // from 0-10
  double _sigmaY = 5; // from 0-10

  @override
  Widget build(BuildContext context) {
    //  Fallback Value
    birthDateInString ??= "";

    // logout the user
    Future logout() async {
      await FirebaseAuth.instance
          .signOut()
          .then((value) => GoogleSignIn().signOut().then((value) {
                Navigator.of(context).pop();
                nextScreenRe(context, homeScreen());
              }));
    }

    // get String phone from firebase to change to phone
    String getPhoneNumberFromFire(String input) {
      RegExp regex = RegExp(r'number:\s*(\d+)'); // find 'number:' in string
      Match? match = regex.firstMatch(input);
      if (match != null) {
        String phoneNumber = match.group(1)!; // number in group
        return phoneNumber;
      } else {
        return "";
      }
    }

    // image picture choose from the photo
    Future<void> _choosePhoto() async {
      final ImagePicker picker = ImagePicker();
      // Pick an image.
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        log('${image.path}  \n ${image.mimeType}');
        // hiding bottomSheet
        setState(() {
          imgPath = image.path;
        });
      }
      AuthProvider.updateProfilePicture(File('$imgPath'));
      Navigator.pop(context);
    }

    // image picture take a photo
    Future<void> _takePhoto() async {
      final ImagePicker picker = ImagePicker();
      // Pick an image.
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        log('${image.path}  \n ${image.mimeType}');
        // hiding bottomSheet
        setState(() {
          imgPath = image.path;
        });
      }
      AuthProvider.updateProfilePicture(File('$imgPath'));
      Navigator.pop(context);
    }

    void _showBodalBottomSheet() {
      showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        backgroundColor: Colors.blue[50],
        useRootNavigator: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: md.height / 4,
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          size: 20.sp,
                        )),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                      onTap: () async {
                        _takePhoto();
                      },
                      child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            children: [
                              Container(
                                height: md.height / 10,
                                width: md.width / 4,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.orange,
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 50.sp,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Take a Photo')
                            ],
                          ))),
                  GestureDetector(
                      onTap: () {
                        _choosePhoto();
                      },
                      child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            children: [
                              Container(
                                height: md.height / 10,
                                width: md.width / 4,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                                child: Icon(
                                  Icons.image,
                                  color: Colors.white,
                                  size: 50.sp,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Choose a photo')
                            ],
                          ))),
                ],
              ),
            ]),
          );
        },
      );
    }

    md = MediaQuery.of(context).size;

    return GestureDetector(
      // for hiding keboard
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: md.width * .03),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizeBoxLine(height: md.height * 0.00005),
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
                                        horizontal: 20),
                                    child: Row(children: []),
                                  ),
                                  sizeBoxLine(height: md.height * 0.00005),

                                  // user profile picture
                                  imgPath != null
                                      ?
                                      // image local
                                      SizedBox(
                                          height: 120.sp,
                                          width: 120.sp,
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            fit: StackFit.expand,
                                            children: [
                                              CircleAvatar(
                                                backgroundImage:
                                                    FileImage(File(imgPath!)),
                                              ),

                                              // CircleAvatar(backgroundImage: Image.file(File(imgPath!))),
                                              Positioned(
                                                  bottom: 0,
                                                  right: -25,
                                                  child: RawMaterialButton(
                                                    onPressed: () {},
                                                    elevation: 2.0,
                                                    fillColor:
                                                        Color(0xFFF5F6F9),
                                                    child: IconButton(
                                                      onPressed: () {
                                                        _showBodalBottomSheet();
                                                      },
                                                      icon: Icon(
                                                          Icons.camera_alt),
                                                    ),
                                                    padding:
                                                        EdgeInsets.all(15.0),
                                                    shape: CircleBorder(),
                                                  )),
                                            ],
                                          ),
                                        )
                                      :
                                      // image from server
                                      Circle_img_profile(
                                          height: 120.sp,
                                          width: 120.sp,
                                          img: '${widget.userModel.image}',
                                          icon: Icons.camera_alt,
                                          color: null,
                                          onPress: () {
                                            _showBodalBottomSheet();
                                          },
                                        ),

                                  sizeBoxLine(height: md.height * 0.00005),
                                  MyTextField_Update(
                                    hintText: null,
                                    obscureText: false,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your full name';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) =>
                                        AuthProvider.me!.name = value ?? '',
                                    outText: widget.userModel.name.toString(),
                                  ),
                                  sizeBoxLine(height: md.height * 0.00002),
                                  MyTextField_Update(
                                    // controller: AboutController,
                                    outText: widget.userModel.about.toString(),
                                    hintText: null,
                                    obscureText: false,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter about yourself';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) =>
                                        AuthProvider.me!.about = value ?? '',
                                  ),
                                  sizeBoxLine(height: md.height * 0.00002),

                                  // select country before the phone number
                                  IntlPhoneField(
                                      disableLengthCheck: true,
                                      initialValue: getPhoneNumberFromFire(
                                          widget.userModel.phone.toString()),
                                      flagsButtonPadding:
                                          const EdgeInsets.all(15),
                                      dropdownIconPosition:
                                          IconPosition.trailing,
                                      decoration: const InputDecoration(
                                        labelText: 'Phone Number',
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(),
                                        ),
                                      ),
                                      initialCountryCode: 'VN',
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Please enter your phone number';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        phone = value.toString();
                                        AuthProvider.me!.phone = phone;
                                      }),

                                  sizeBoxLine(height: md.height * 0.00002),
                                  SizedBox(
                                    height: md.height * 0.08,
                                    child: TextFormField(
                                      controller:
                                          _dateinput, //editing controller of this TextField
                                      decoration: InputDecoration(
                                          icon: Icon(Icons
                                              .calendar_today), //icon of text field
                                          labelText:
                                              "Enter Date of Birth" //label text of field
                                          ),
                                      readOnly:
                                          true, //set it true, so that user will not able to edit text
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(
                                                    2000), //DateTime.now() - not to allow to choose before today.
                                                lastDate: DateTime(2101));

                                        if (pickedDate != null) {
                                          print(
                                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                          String formattedDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(pickedDate);
                                          print(formattedDate);
                                          setState(() {
                                            _dateinput.text =
                                                formattedDate; //set output date to TextField value.
                                          });
                                        } else {
                                          _dateinput.text = widget
                                              .userModel.dateOfBirth
                                              .toString();
                                          print("Date is not selected");
                                        }
                                      },

                                      onSaved: (value) => AuthProvider
                                          .me!.dateOfBirth = value ?? '',
                                    ),
                                  ),

                                  sizeBoxLine(height: md.height * 0.00005),
                                  MyButton(
                                    height: md.height * .06,
                                    width: md.height * .25,
                                    style: textString.text_ButtonSmall,
                                    text: 'Updates',
                                    onTap: (() {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        AuthProvider.updateUserInfo();
                                        dialogs.showSnackBarSuccessfully(
                                            context, 'Update successful');
                                      } else {
                                        dialogs.showSnackBar(
                                            context, 'Update not successful');
                                      }
                                    }),
                                    color: colors.main_color.withOpacity(0.9),
                                    icon: Icons.update_rounded,
                                    border: 25,
                                  ),
                                  sizeBoxLine(height: md.height * 0.00005),

                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: md.width * 0.5),
                                    child: MyButton(
                                      height: md.height * .06,
                                      width: md.height * .15,
                                      style: textString.text_ButtonSmall,
                                      text: 'Logout',
                                      onTap: (() {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Are you sure?'),
                                              actions: [
                                                TextButton(
                                                  child: Text('Close'),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(); // Close the dialog
                                                  },
                                                ),
                                                TextButton(
                                                    onPressed: () {
                                                      logout();
                                                    },
                                                    child: Text('Yes'))
                                              ],
                                            );
                                          },
                                        );
                                      }),
                                      color: Colors.red.withOpacity(0.9),
                                      icon: Icons.logout,
                                      border: 25,
                                    ),
                                  )
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
