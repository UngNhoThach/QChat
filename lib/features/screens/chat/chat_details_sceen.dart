import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
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
          backgroundColor: Colors.white,
          flexibleSpace: _appBar(),
        ),
        body: Column(
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

                    // scroll position at the end of the list
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (_scrollController.hasClients) {
                        _scrollController
                            .jumpTo(_scrollController.position.maxScrollExtent);
                      }
                    });
                    return _listMessages.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            controller: _scrollController,
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
                              style: TextStyle(fontSize: 18, color: Colors.red),
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
                    setState(() {
                      _emojiShowing = !_emojiShowing; // Show and hide icon
                    });
                },
                controller: textInputController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  contentPadding: EdgeInsets.all(
                      10), // Optional: Adjust padding around the input
                  filled: true,
                  hintText: "Write message...",
                  hintStyle: TextStyle(color: Colors.black54),
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
              //   final ImagePicker imagePicker = ImagePicker();
              // List<XFile>? imageFileList = [];

              // void selectImages() async {
              //   final List<XFile>? selectedImages = await
              //           imagePicker.pickMultiImage();
              //     if (selectedImages!.isNotEmpty) {
              //         imageFileList.addAll(selectedImages);
              //     }
              //     print("Image List Length:" + imageFileList!.length.toString());
              //     setState((){});
              // }
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
                if (textInputController.text.isNotEmpty) {
                  _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut);
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
                // verticalSpacing: 0,
                // horizontalSpacing: 0,
                // gridPadding: EdgeInsets.zero,
                // initCategory: Category.RECENT,
                // bgColor: const Color(0xFFF2F2F2),
                // indicatorColor: Colors.blue,
                // iconColor: Colors.grey,
                // iconColorSelected: Colors.blue,
                // backspaceColor: Colors.blue,
                // skinToneDialogBgColor: Colors.white,
                // skinToneIndicatorColor: Colors.grey,
                // enableSkinTones: true,
                // recentTabBehavior: RecentTabBehavior.RECENT,
                // recentsLimit: 28,
                // replaceEmojiOnLimitExceed: false,
                // noRecents: const Text(
                //   'No Recents',
                //   style: TextStyle(fontSize: 20, color: Colors.black26),
                //   textAlign: TextAlign.center,
                // ),
                // loadingIndicator: const SizedBox.shrink(),
                // tabIndicatorAnimDuration: kTabScrollDuration,
                // categoryIcons: const CategoryIcons(),
                // buttonMode: ButtonMode.MATERIAL,
                // checkPlatformCompatibility: true,
              ),
            )));
  }
}
