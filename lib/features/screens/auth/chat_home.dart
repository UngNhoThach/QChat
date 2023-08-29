import 'package:flutter/material.dart';
import 'package:qchat/constants/colors.dart';

import '../../models/chat_user_model.dart';
import '../chat/chat_group_screen.dart';
import '../chat/chat_profile_screen.dart';
import '../chat/chat_user_screen.dart';
import '../../../provider/auth_provider.dart';
import '../chat/setting_screen.dart';

class chatHome extends StatefulWidget {
  const chatHome({super.key});

  @override
  State<chatHome> createState() => _chatHomeState();
}

class _chatHomeState extends State<chatHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // chat_user_screen();
    AuthProvider.getSelfInformation();
    AuthProvider.FCMtoken();
  }

  int currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // bottomNavigationBar
    final List<Widget> _chat_children = [
      chat_user_screen(),
      chat_group_screen(),
      chat_profile_screen(
        // return Fallback Value Map
        userModel: AuthProvider.me ??= chatUserModel.fromJson({}),
      ),
      setting_screen(),
    ];

    return Scaffold(
      body: _chat_children[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: colors.main_color,
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        onTap: onTabTapped,
        currentIndex: currentIndex,
        // type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_work),
            label: "Group",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],

        // _showBodalBottomSheet
      ),
    );
  }
}
