import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qchat/features/models/chat_user_model.dart';
import 'package:qchat/features/screens/chat/widgets/chat_details_widget.dart';
import 'package:qchat/provider/auth_provider.dart';
import '../../../constants/colors.dart';

import '../../../../main.dart';
import '../../models/chat_details_model.dart';

class chatDetails extends StatefulWidget {
  final chatUserModel userModel;
  const chatDetails({super.key, required this.userModel});

  @override
  State<chatDetails> createState() => _chatDetailsState();
}

class _chatDetailsState extends State<chatDetails> {
  // list chat messages
  List<messagesModel> _listMessages = [];

  @override
  Widget build(BuildContext context) {
    md = MediaQuery.of(context).size;
    return GestureDetector(
      // for hiding keyboard when a tap is detected on screen
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          flexibleSpace: _appBar(),
        ),
        body: Stack(
          children: <Widget>[
            // chat messages
            _chatMessage(),

            // chat Input
            Align(
              alignment: Alignment.bottomLeft,
              child: _chatInput(),
            ),
          ],
        ),
      ),
    );
  }

  // widget chat Message
  Widget _chatMessage() {
    return StreamBuilder(
      stream: AuthProvider.getAllMessages(widget.userModel),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading data'));
        } else {
          final data = snapshot.data?.docs;
          log('Data:  ${jsonEncode(data![0].data())}');
          return _listMessages.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: _listMessages.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return chat_details_widget(
                      messModel: _listMessages[index],
                    );
                  })
              : Center(
                  child: Text(
                    'No results found',
                    style: TextStyle(fontSize: 18, color: colors.color_button),
                  ),
                );
        }
      },
    );
  }

  // widget app Bar chat
  Widget _appBar() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(right: 15, top: 15),
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: md.width / 90,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage("${widget.userModel.image}"),
              maxRadius: 20,
            ),
            SizedBox(
              width: md.width / 30,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${widget.userModel.name}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: md.width / 45,
                  ),
                  Text(
                    "Last time on online",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.settings,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }

  // widget chat Inputs
  Widget _chatInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: md.height / 16,
      width: double.infinity,
      color: Colors.white,
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Center horizontally
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.insert_emoticon_rounded,
              color: colors.color_button,
              weight: 20,
              size: 30,
            ),
            onPressed: () {},
          ),
          SizedBox(
            width: md.width / 28,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Write message...",
                  hintStyle: TextStyle(color: Colors.black54),
                  border: InputBorder.none),
            ),
          ),
          SizedBox(
            width: md.width / 28,
          ),
          IconButton(
            icon: Icon(
              Icons.image,
              color: colors.color_button,
              weight: 20,
              size: 30,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.camera_alt,
              color: colors.color_button,
              weight: 20,
              size: 30,
            ),
            onPressed: () {},
          ),
          SizedBox(
            width: md.width / 28,
          ),
          Container(
            height: md.height / 20,
            width: md.width / 6,
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () {},
              child: Icon(
                Icons.send,
                color: Colors.white,
                size: 25,
              ),
              backgroundColor: Colors.green,
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}
