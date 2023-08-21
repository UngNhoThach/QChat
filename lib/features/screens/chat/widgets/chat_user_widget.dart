import 'package:flutter/material.dart';
import 'package:qchat/main.dart';
import '../../../models/chat_user_model.dart';
import '../../../widgets/nextscreen.dart';
import '../chat_details_sceen.dart';

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

  // waitting for checkSatusUser run first
  Future<void> _initializeData() async {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration.zero).then((value) => checkSatusUser());

    _initializeData();
  }

  @override
  Widget build(BuildContext context) {
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
          child: ListTile(
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
                  Positioned(
                    bottom: 0,
                    right: 10,
                    child: CircleAvatar(
                      backgroundColor: widget.colorList[widget.index],
                      radius: 8,
                    ),
                  ),
                ],
              ),
            ),

            // name of the user
            title: Text(widget.userModel.name.toString()),

            // details of the user
            subtitle: Text(
              widget.userModel.about.toString(),
              maxLines: 1,
            ),

            // last message of the user
            trailing: Text(
              '9:00 AM',
              style: TextStyle(color: Colors.black54),
            ),
          )),
    );
  }
}
