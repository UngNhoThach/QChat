import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qchat/provider/auth_provider.dart';
import '../../../../utils/date_utils.dart';
import '../../../models/chat_details_model.dart';

class chat_details_widget extends StatefulWidget {
  final messagesModel messModel;

  const chat_details_widget({super.key, required this.messModel});

  @override
  State<chat_details_widget> createState() => _chat_details_widgetState();
}

class _chat_details_widgetState extends State<chat_details_widget> {
  @override
  Widget build(BuildContext context) {
    return AuthProvider.user.uid == widget.messModel.from_uid
        ? _sendMessage()
        : _receiveMessage();
  }

  // send message

  Widget _sendMessage() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 30),
      child: Align(
          // alignment: Alignment.topLeft,
          child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Column(
              children: [
                Text('${date_utils.readTimestamp(widget.messModel.time_sent)}'),
                widget.messModel.last_time.isNotEmpty
                    ? Text('Đã xem',
                        style: TextStyle(fontSize: 13, color: Colors.green))
                    : Text('Đã gửi',
                        style: TextStyle(fontSize: 13, color: Colors.green)),
              ],
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          Container(
            alignment: AlignmentDirectional.centerEnd,
            width: 260.w,
            child: Wrap(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 89, 189, 232),
                      border:
                          Border.all(color: Color.fromARGB(255, 17, 17, 18)),
                      //making borders curved
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  constraints: BoxConstraints(maxHeight: double.infinity),
                  padding: EdgeInsets.all(15),
                  child: Text(
                    widget.messModel.msg,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  // receive message
  Widget _receiveMessage() {
    if (widget.messModel.last_time.isEmpty) {
      try {
        AuthProvider.updateLastMessage(widget.messModel);
      } catch (e) {
        log('${e}');
      }
    }
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 30),
      child: Align(
          // alignment: Alignment.topLeft,
          child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: AlignmentDirectional.centerStart,
            width: 260.w,
            child: Wrap(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: (Colors.grey.shade200),
                  ),
                  constraints: BoxConstraints(maxHeight: double.infinity),
                  padding: EdgeInsets.all(15),
                  child: Text(
                    widget.messModel.msg,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          Flexible(
            child: Column(
              children: [
                Text('${date_utils.readTimestamp(widget.messModel.time_sent)}'),
                widget.messModel.last_time.isNotEmpty
                    ? Text('Đã xem',
                        style: TextStyle(fontSize: 13, color: Colors.green))
                    : Text('Đã gửi',
                        style: TextStyle(fontSize: 13, color: Colors.green)),
              ],
            ),
          )
        ],
      )),
    );
  }
}
