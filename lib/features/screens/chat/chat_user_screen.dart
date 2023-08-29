import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qchat/constants/textString.dart';
import 'package:qchat/features/screens/chat/widgets/chat_user_widget.dart';

import 'package:qchat/provider/auth_provider.dart';
import '../../../../main.dart';
import '../../models/chat_user_model.dart';
import '../../../constants/colors.dart';
import '../../widgets/button.dart';

class chat_user_screen extends StatefulWidget {
  const chat_user_screen({super.key});

  @override
  State<chat_user_screen> createState() => _chat_user_screenState();
}

class _chat_user_screenState extends State<chat_user_screen> {
  Color? colorOn;
  List<Color> colorList = [];

  // list of users all
  List<chatUserModel> _list = [];

  // list of users searching
  List<chatUserModel> _listSearching = [];

  // list empty to filter users
  List<chatUserModel> results = [];

  // filter user future
  late Future<void> _userListFuture;

  // function add user and color to list
  Future<void> userList(
      Stream<QuerySnapshot<Map<String, dynamic>>> stream) async {
    final snapshot = await stream.first;
    final data = snapshot.docs;
    colorList.clear(); // clear old date colorList befere add the new
    _list = data.map((e) => chatUserModel.fromJson(e.data())).toList();
    if (_list.isEmpty) {
      return;
    } else {
      for (final user in _list) {
        bool isOnline = await user.isOnline!; // check stauts
        if (isOnline == true) {
          colorList.add(Colors.green);
        } else {
          colorList.add(Colors.red);
        }
      }
      _listSearching = List.from(_list);
    }
    setState(() {});
  }

// function hander filter user
  void searchHandler(String value) {
    if (value.isEmpty) {
      results = _list;
    } else {
      results = _list
          .where((user) =>
              user.name!.toLowerCase().contains(value.toLowerCase()) ||
              user.email!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    setState(() {
      _listSearching = results;
    });
  }

  @override
  void initState() {
    super.initState();
    _userListFuture = userList(AuthProvider.getAllUsers());

    // for setting user status to active default when user login is true active
    AuthProvider.updateStatusUser(true);

    // for updating user status according to lifecycle events
    SystemChannels.lifecycle.setMessageHandler((message) {
      // ignore: unnecessary_null_comparison
      if (AuthProvider.auth.currentUser != null) {
        if (message.toString().contains('resume'))
          AuthProvider.updateStatusUser(true);
        if (message.toString().contains('pause'))
          AuthProvider.updateStatusUser(false);
        if (message.toString().contains('inactive')) {
          AuthProvider.updateStatusUser(
              false); // Xử lý khi ứng dụng bị tạm dừng hoàn toàn
        }
      }
      return Future.value(message);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    md = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.all(15),
      child: GestureDetector(
        // for hiding keyboard when a tap is detected on screen
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Conversations", style: textString.heading3),
                        buttonTextandIcon(
                          colorBr: colors.color_button,
                          colorSn: const Color.fromARGB(255, 10, 10, 10),
                          icon: Icons.add,
                          onPress: () {
                            setState(() {});
                          },
                          sizeIcon: 16.sp,
                          height: 30.h,
                          width: null,
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          text: 'Add New',
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: SizedBox(
                    height: 40.h,
                    child: TextField(
                      // when search text changes then update user search
                      onChanged: (value) {
                        searchHandler(value);
                      },

                      decoration: InputDecoration(
                        hintText: "Search...",
                        hintStyle: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13.sp),
                        prefixIcon: IconButton(
                          onPressed: () => {},
                          icon: Icon(Icons.search),
                          color: Colors.grey.shade600,
                          iconSize: 20.sp,
                        ),
                        fillColor: Colors.grey.shade100,
                        border: InputBorder.none,
                        enabledBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0.sp),
                          borderSide: BorderSide(color: Colors.grey.shade900),
                        ),
                        focusedBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0.sp),
                          // borderSide: BorderSide(color: Colors.lightBlueAccent),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: FutureBuilder(
                    future: _userListFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error loading data'));
                      } else {
                        return _listSearching.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: _listSearching.length,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return chat_user_widget(
                                    userModel: _listSearching[index],
                                    colorList: colorList,
                                    index: index,
                                  );
                                })
                            : Center(
                                child: Text(
                                  'No results found',
                                  style: TextStyle(
                                      fontSize: 18, color: colors.color_button),
                                ),
                              );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
