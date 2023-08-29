import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qchat/features/models/chat_user_model.dart';
import 'package:qchat/features/screens/chat/view_profile_screen.dart';
import 'package:qchat/features/screens/chat/widgets/chat_details_widget.dart';
import 'package:qchat/features/widgets/nextscreen.dart';
import 'package:qchat/provider/auth_provider.dart';
import '../../../constants/colors.dart';
import '../../../../utils/date_utils.dart';
import '../../../../main.dart';
import '../../models/chat_details_model.dart';
import 'chat_profile_screen.dart';

class chatDetails extends StatefulWidget {
  final chatUserModel userModel;
  const chatDetails({super.key, required this.userModel});

  @override
  State<chatDetails> createState() => _chatDetailsState();
}

class _chatDetailsState extends State<chatDetails> {
  //variables
  bool _emojiShowing = false;
  bool _isUploading = false;
  String? imgPath;

  //controller
  final textInputController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  // list chat messages
  List<messagesModel> _listMessages = [];

  void dispose() {
    super.dispose();
    textInputController.dispose();
  }

  void initState() {
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
    super.initState();
  }

  //chuyển đổi chuỗi văn bản thành một chuỗi ký tự, sau
  // đó đặt con trỏ ở cuối chuỗi để cho phép người dùng tiếp tục nhập liệu
  _onBackspacePressed() {
    textInputController
      ..text = textInputController.text.characters.toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: textInputController.text.length));
  }

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
          flexibleSpace: _appBar(),
        ),
        body: Container(
          height: md.height,
          width: md.width,
          child: Column(
            children: <Widget>[
              Expanded(
                // chat messages
                child: StreamBuilder(
                  stream: AuthProvider.getAllMessages(widget.userModel),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error loading data'));
                    } else {
                      final data = snapshot.data?.docs;
                      // add data into list
                      _listMessages = data
                              ?.map((e) => messagesModel.fromJson(e.data()))
                              .toList() ??
                          [];

                      return SingleChildScrollView(
                        // Jump to the specified index position with animation.
                        controller: _scrollController,
                        child: _listMessages.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: _listMessages.length,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        top: 15,
                                        left: 15,
                                        right: 15,
                                        bottom:
                                            15), // Standard padding for other items
                                    child: chat_details_widget(
                                      messModel: _listMessages[index],
                                    ),
                                  );
                                })
                            : Center(
                                child: Text(
                                  'Hi Qchat',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.red),
                                ),
                              ),
                      );
                    }
                  },
                ),
              ),
              // _isUploading ìf waiting for upload
              if (_isUploading)
                Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                        padding: EdgeInsets.all(30),
                        child: CircularProgressIndicator())),

              // chat Input
              _chatInput(),
              if (_emojiShowing) emojiSelect(),
            ],
          ),
        ),
      ),
    );
  }

  // widget app Bar chat
  Widget _appBar() {
    return InkWell(
      onTap: () {
        nextScreen(context, view_profile_screen(userModel: widget.userModel));
      },
      child: StreamBuilder(
          stream: AuthProvider.getUserInfo(widget.userModel),
          builder: (context, snapshot) {
            final data = snapshot.data?.docs;
            // add data into list
            final _listInfoUser =
                data?.map((e) => chatUserModel.fromJson(e.data())).toList() ??
                    [];

            return SafeArea(
              child: Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: md.width / 90,
                    ),
                    CircleAvatar(
                      backgroundImage: _listInfoUser.isNotEmpty
                          ? NetworkImage("${_listInfoUser[0].image}")
                          : NetworkImage("${widget.userModel.image}"),
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
                            _listInfoUser.isNotEmpty
                                ? '${_listInfoUser[0].name}'
                                : '${widget.userModel.name}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: md.width / 45,
                          ),
                          Text(
                            style: TextStyle(color: Colors.white, fontSize: 13),
                            _listInfoUser.isNotEmpty
                                ? _listInfoUser[0].isOnline == true
                                    ? 'Online'
                                    : '${date_utils.readTimestamp('${_listInfoUser[0].lastOnline}')}'
                                : '${widget.userModel.lastOnline}',
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  // widget chat Inputs
  Widget _chatInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      height: md.height / 16,
      width: double.infinity,
      color: Colors.white,
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Center horizontally
        children: <Widget>[
          IconButton(
            // pick emoji
            icon: Icon(
              Icons.insert_emoticon_rounded,
              color: colors.color_button,
              weight: 15.w,
              size: 25.sp,
            ),
            onPressed: () {
              FocusScope.of(context).unfocus();
              setState(() {
                // Show and hide image and camera icons
                _emojiShowing = !_emojiShowing; // Show and hide icon
              });
            },
          ),
          SizedBox(
            width: md.width / 60,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                onTap: () {
                  if (_emojiShowing)
                    _emojiShowing = !_emojiShowing; // Show and hide icon

                  setState(() {});
                },
                controller: textInputController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0.sp),
                  ),
                  contentPadding: EdgeInsets.all(
                      10.sp), // Optional: Adjust padding around the input
                  filled: true,
                  hintText: "Write message...",
                  hintStyle: TextStyle(color: Colors.black54, fontSize: 13.sp),
                ),
              ),
            ),
          ),
          SizedBox(
            width: md.width / 60,
          ),
          IconButton(
            icon: Icon(
              Icons.image,
              color: colors.color_button,
              weight: 15.w,
              size: 25.sp,
            ),
            onPressed: () async {
              // send messages images choose multiple images.
              final ImagePicker picker = //
                  ImagePicker();
              // Pick multiple images.
              final List<XFile?> images =
                  await picker.pickMultiImage(imageQuality: 50);
              // pick an image and send image multiple
              for (var i in images) {
                setState(() => _isUploading = true);
                await AuthProvider.sendMessagesImage(
                    widget.userModel, File(i!.path));
                setState(() => _isUploading = false);
              }
            },
          ),
          IconButton(
            icon: Icon(
              Icons.camera_alt,
              color: colors.color_button,
              weight: 15.w,
              size: 25.sp,
            ),
            onPressed: () async {
              //send messages image take a photo

              final ImagePicker picker = ImagePicker();
              // Pick an image.
              final XFile? image = await picker.pickImage(
                  source: ImageSource.camera, imageQuality: 50);
              if (image != null) {
                // hiding bottomSheet
                setState(() => _isUploading = true);

                imgPath = image.path;
                AuthProvider.sendMessagesImage(
                    widget.userModel, File('${imgPath}'));
                setState(() => _isUploading = false);
              }
            },
          ),
          SizedBox(
            width: md.width / 60,
          ),
          Container(
            height: md.height / 20,
            width: md.width / 6,
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () {
                _navigateToBottom();
                if (textInputController.text.isNotEmpty) {
                  AuthProvider.sendMessages(
                      widget.userModel, textInputController.text, Type.text);
                  textInputController.text = ' ';
                }
              },
              child: Icon(
                Icons.send,
                color: Colors.white,
                size: 25.sp,
              ),
              backgroundColor: Colors.green,
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  // widget emojiselect
  Widget emojiSelect() {
    return Offstage(
        offstage: !_emojiShowing,
        child: SizedBox(
            height: 250.h,
            child: EmojiPicker(
              textEditingController: textInputController,
              onBackspacePressed: _onBackspacePressed,
              config: Config(
                columns: 7,
                emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
              ),
            )));
  }

  // scroll to bottom of screen
  void _navigateToBottom() {
    final Duration duration = Duration(milliseconds: 800);
    final Curve curve = Curves.easeOut;
    final position = _scrollController.position.maxScrollExtent;

    if (_scrollController.hasClients) {
      var scrollPosition = this._scrollController.position;

      scrollPosition.animateTo(
        position,
        duration: duration,
        curve: curve,
      );
    }
  }
}
