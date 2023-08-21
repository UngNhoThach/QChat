import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:qchat/provider/auth_provider.dart';

import '../../../models/chat_details_model.dart';

class chat_details_widget extends StatefulWidget {
  final messagesModel messModel;
  const chat_details_widget({super.key, required this.messModel});

  @override
  State<chat_details_widget> createState() => _chat_details_widgetState();
}

class _chat_details_widgetState extends State<chat_details_widget> {
  // List<chatMessage_model> messages = [
  //   chatMessage_model(messContent: "Hello, Will", messType: "receiver"),
  //   chatMessage_model(messContent: "How have you been?", messType: "receiver"),
  //   chatMessage_model(
  //       messContent: "Hey Kriss, I am doing fine dude. wbu?",
  //       messType: "sender"),
  //   chatMessage_model(messContent: "ehhhh, doing OK.", messType: "receiver"),
  //   chatMessage_model(
  //       messContent: "Is there any thing wrong?", messType: "sender"),
  // ];

  @override
  Widget build(BuildContext context) {
    return AuthProvider.user.uid == widget.messModel.ID
        ? _receiveMessage()
        : _sendMessage();
  }

  // send message
  Widget _sendMessage() {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: (Colors.blue[200]),
          ),
          padding: EdgeInsets.all(16),
          child: Text(
            widget.messModel.msg,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }

  // receive message
  Widget _receiveMessage() {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: (Colors.grey.shade200),
            // : Colors.blue[200]),
          ),
          padding: EdgeInsets.all(16),
          child: Text(
            widget.messModel.msg,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
