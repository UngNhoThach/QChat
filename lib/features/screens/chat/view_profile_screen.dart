import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';
import 'package:qchat/main.dart';
import 'package:qchat/provider/auth_provider.dart';
import 'package:qchat/utils/date_utils.dart';
import '../../models/chat_user_model.dart';
import '../../widgets/sizeBox.dart';
import '../../widgets/square.dart';
import '../../widgets/textFild.dart';

class view_profile_screen extends StatefulWidget {
  final chatUserModel userModel;

  const view_profile_screen({super.key, required this.userModel});

  @override
  State<view_profile_screen> createState() => _view_profile_screenState();
}

class _view_profile_screenState extends State<view_profile_screen> {
  @override
  void initState() {
    super.initState();
  }

  //variables
  String? imgPath;

  double _sigmaX = 5; // from 0-10
  double _sigmaY = 5; // from 0-10

  @override
  Widget build(BuildContext context) {
    md = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.userModel.name}',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: Container(
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
                    filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(children: []),
                            ),
                            sizeBoxLine(height: md.height * 0.00005),

                            // user profile picture
                            imgPath != null
                                ?
                                // image local
                                SizedBox(
                                    height: 200.h,
                                    width: 200.w,
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      fit: StackFit.expand,
                                      children: [
                                        CircleAvatar(
                                          backgroundImage:
                                              FileImage(File(imgPath!)),
                                        ),
                                      ],
                                    ),
                                  )
                                :

                                // image from server
                                SizedBox(
                                    height: 200.h,
                                    width: 200.w,
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      fit: StackFit.expand,
                                      children: [
                                        CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                '${widget.userModel.image}')),
                                      ],
                                    ),
                                  ),

                            sizeBoxLine(height: md.height * 0.00002),
                            Text(
                              '${widget.userModel.name}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            sizeBoxLine(height: md.height * 0.00002),
                            Text(
                              '${widget.userModel.email}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Joined :',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 10), // Khoảng cách giữa hai Text

                      Text(
                        '${date_utils.readTimestampToYear('${widget.userModel.createAt}')}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
