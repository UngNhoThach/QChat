import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qchat/features/models/chat_details_model.dart';
import 'package:qchat/main.dart';
import 'package:qchat/provider/auth_provider.dart';
import '../../../models/chat_user_model.dart';
import '../../../widgets/nextscreen.dart';
import '../chat_details_sceen.dart';
import '../../../../utils/date_utils.dart';

class chat_user_widget extends StatefulWidget {
  final chatUserModel userModel;
  final List<Color> colorList; // Thêm thuộc tính colorList
  final int index; // Nhận giá trị index từ lớp cha

  const chat_user_widget(
      {super.key,
      required this.userModel,
      required this.colorList,
      required this.index});

  @override
  State<chat_user_widget> createState() => _chat_user_widgetState();
}

class _chat_user_widgetState extends State<chat_user_widget> {
// variables

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    messagesModel? _mess;
    md = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: InkWell(
          onTap: () {
            nextScreen(
                context,
                chatDetails(
                  userModel: widget.userModel,
                ));
          },
          child: StreamBuilder(
            stream: AuthProvider.getLastMessage(widget.userModel),
            builder: (context, snapshot) {
              // check snapshot is null or not null
              if (snapshot.hasData) {
                final data = snapshot.data!.docs;
                final _list =
                    data.map((e) => messagesModel.fromJson(e.data())).toList();
                if (data.first.exists) {
                  _mess = _list[0];
                }
              } else {}
              return ListTile(
                // user profile picture
                leading: SizedBox(
                  height: md.height * 0.08,
                  width: md.height * 0.08,
                  child: Stack(
                    clipBehavior: Clip.none,
                    fit: StackFit.expand,
                    children: [
                      CircleAvatar(
                          backgroundImage:
                              NetworkImage('${widget.userModel.image}')),
                      // user online or offline
                      Positioned(
                        bottom: 0,
                        right: 10.w,
                        child: CircleAvatar(
                          backgroundColor: _mess == null
                              ? null
                              : _mess!.last_time.isEmpty &&
                                      _mess!.from_uid != AuthProvider.user.uid
                                  ? Colors.green
                                  : Colors.grey,
                          radius: 8,
                        ),
                      ),
                    ],
                  ),
                ),

                // name of the user
                title: Text(widget.userModel.name.toString()),

                //last messages or details of the user
                subtitle: Text(
                  _mess != null
                      ? _mess?.type == Type.text // type text out put text
                          ? _mess!.msg
                          : _mess!.type.name // type image out put image
                      : widget.userModel.about.toString(),
                  maxLines: 1,
                ),

                // last message
                trailing: Text(
                  '${date_utils.readTimestamp(_mess == null ? '' : _mess!.time_sent)}',
                  style: TextStyle(color: Colors.black54),
                ),
              );
            },
          )),
    );
  }
}
