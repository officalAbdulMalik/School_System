import 'dart:io';

import 'package:chat_bubbles/bubbles/bubble_special_two.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_system/Controllers/Cubits/CommonCubit/create_chat_cubit.dart';
import 'package:school_system/Controllers/firebase_repos/add_chat_message.dart';
import 'package:school_system/Controllers/firebase_repos/chat_components.dart';
import 'package:school_system/Models/Chats/chat_model.dart';
import 'package:school_system/Presentation/common/resources/dailog.dart';
import 'package:school_system/Presentation/utils/app_images.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/Presentation/utils/custom_widget/image_widget.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';

import '../../../../models/chat_model.dart';

class ChatDetailsScreen extends StatefulWidget {
  const ChatDetailsScreen({
    Key? key,
    this.docId,
    this.model,
  }) : super(key: key);

  final String? docId;
  final ChatsUsers? model;

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  File? selectedImage;

  String? userType = LoginApiShadePreference.preferences!.getString('type');
  String? userImage = LoginApiShadePreference.preferences!.getString('image');

  TextEditingController messageController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  moveLastMessage() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(userImage.toString());
    return SafeArea(
      child: BlocListener<CreateChatCubit, CreateChatState>(
        listener: (context, state) {
          if (state is CreateChatLoading) {
            Dialogs.uploadingDialog(
              context,
            );
          }
          if (state is CreateChatLoaded) {
            Navigator.pop(context);
            // moveLastMessage();
            selectedImage = null;
          }
          // TODO: implement listener
        },
        child: Scaffold(
            body: selectedImage == null
                ? Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 10.sp),
                        height: 65.sp,
                        color: Colors.white,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.arrow_back),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  CachedImage(
                                    radius: 20.r,
                                      url:widget.model!.profileImage??""),
                                  SizedBox(
                                    width: 4.sp,
                                  ),
                                  SizedBox(width: 5.w,),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        MyText(
                                          widget.model?.firstName??"",
                                          fontSize: 14.sp,
                                          color: Colors.black,
                                        ),
                                        MyText(
                                          widget.model?.userType ?? "",
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.info_outline,
                                    color: Color(0xff6B7280),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 70.sp,
                      //   child: Row(
                      //     mainAxisSize: MainAxisSize.min,
                      //     children: [
                      //       Container(
                      //         height: 50.sp,
                      //         width: 50.sp,
                      //         decoration: BoxDecoration(
                      //             shape: BoxShape.circle,
                      //             color: Colors.white,
                      //             boxShadow: [
                      //               BoxShadow(
                      //                   color: Colors.grey.withAlpha(60), blurRadius: 4),
                      //             ]),
                      //         child: Center(
                      //           child: SvgPicture.asset(AppImages.phoneIcon),
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         width: 16.sp,
                      //       ),
                      //       Container(
                      //         height: 48.sp,
                      //         width: 48.sp,
                      //         decoration: BoxDecoration(
                      //             shape: BoxShape.circle,
                      //             color: Colors.white,
                      //             boxShadow: [
                      //               BoxShadow(
                      //                   color: Colors.grey.withAlpha(60), blurRadius: 4),
                      //             ]),
                      //         child: Center(
                      //           child: SvgPicture.asset(AppImages.videoCallIcon),
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         width: 16.sp,
                      //       ),
                      //       Container(
                      //         height: 48.sp,
                      //         width: 48.sp,
                      //         decoration: BoxDecoration(
                      //             shape: BoxShape.circle,
                      //             color: Colors.white,
                      //             boxShadow: [
                      //               BoxShadow(
                      //                   color: Colors.grey.withAlpha(60), blurRadius: 4),
                      //             ]),
                      //         child: Center(
                      //           child: SvgPicture.asset(AppImages.calenderIcon),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Expanded(
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('Chat')
                                .doc(widget.docId ?? "")
                                .collection('chats')
                                .orderBy("time_tempt")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.data != null) {

                                List<QueryDocumentSnapshot> chatDocuments =
                                    snapshot.data!.docs;


                                return ListView.builder(
                                  controller: _scrollController,
                                  physics: const BouncingScrollPhysics(),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.sp),
                                  //  reverse: true,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    var chatData =
                                    chatDocuments[index].data() as Map<String, dynamic>;
                                    ChatsMessage messageData = ChatsMessage.fromMap(chatData);
                                    String? sendBy =
                                       messageData.sendBy;

                                    print(sendBy);

                                    return  sendBy == userType
                                        ? ChatComponents().receiver(
                                            index,
                                            snapshot.data!.docs,
                                            context,
                                            userImage!)
                                        : ChatComponents().getSenderMessageCard(
                                            index,
                                            snapshot.data!.docs,
                                            widget.model!.profileImage??"",
                                            context);

                                    // : receiver(index);
                                  },
                                );
                              } else {
                                return const Center(
                                    child: Text('Chat not found'));
                              }
                            }),
                      ),
                      Container(
                        // padding: EdgeInsets.symmetric(horizontal: 10.sp,vertical: 10.sp),
                        margin: EdgeInsets.only(
                            left: 16.sp, right: 16.sp, bottom: 29.sp),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.sp),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withAlpha(70),
                                  blurRadius: 5,
                                  offset: const Offset(3, 5))
                            ]),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () async {
                                  FilePickerResult file =
                                      await ChatComponents().pickImage();

                                  selectedImage = File(file.paths.first!);
                                  setState(() {});
                                },
                                icon: const Icon(CupertinoIcons.photo,
                                    color: Color(0xff6B7280))),
                            IconButton(
                                onPressed: () {
                                  ChatComponents()
                                      .pickFile(widget.docId!, context);
                                },
                                icon: const Icon(Icons.attach_file_outlined,
                                    color: Color(0xff6B7280))),
                            // IconButton(
                            //     onPressed: () {},
                            //     icon: const Icon(Icons.mic, color: Color(0xff6B7280))),
                            Expanded(
                              flex: 3,
                              child: TextField(
                                controller: messageController,
                                maxLines: null,
                                decoration: const InputDecoration(
                                    hintText: 'Write you message',
                                    border: InputBorder.none),
                              ),
                            ),
                            InkWell(
                                onTap: () {
                                  FirebaseHelper()
                                      .addChat(widget.docId!,
                                          messageController.text.trim())
                                      .then((value) {
                                    moveLastMessage();
                                  });
                                  messageController.clear();
                                },
                                child: SvgPicture.asset(AppImages.sendIcon)),
                            SizedBox(
                              width: 4.sp,
                            ),
                          ],
                        ),
                      ),

                      // MessageBar(
                      //   messageBarColor: kButtonColor,
                      //   sendButtonColor: Colors.white,
                      //   onSend: (chat) {
                      //     FocusManager.instance.primaryFocus?.unfocus();
                      //     // Helper.startChat('', chat);
                      //   },
                      // ),
                    ],
                  )
                : showSelectedImage(widget.docId!)),
      ),
    );
  }

  showSelectedImage(String docID) {
    return SizedBox(
      height: 1.sh,
      width: 1.sw,
      child: Stack(
        children: <Widget>[
          Image.file(
            selectedImage!,
            fit: BoxFit.cover,
            width: 1.sw,
            height: 1.sh,
          ),
          Positioned(
              top: 10.sp,
              left: 10,
              child: InkWell(
                onTap: () {
                  selectedImage = null;
                  setState(() {});
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30.sp,
                ),
              )),
          Positioned(
              bottom: 10.sp,
              left: 20.sp,
              right: 20.sp,
              child: Row(
                children: [
                  Expanded(
                    child: CustomWidgets.customButton('Send', onTap: () async {
                      await context
                          .read<CreateChatCubit>()
                          .addFileInChat(docID, 'png', selectedImage!.path);
                    }),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}

//                            return BubbleSpecialTwo(
//                               text: index == 1
//                                   ? 'Hello'
//                                   : index == 2
//                                       ? "hi"
//                                       : 'hello',
//                               isSender: index == 1
//                                   ? false
//                                   : index == 2
//                                       ? true
//                                       : index == 3
//                                           ? false
//                                           : true,
//                               color: Colors.black,
//                               textStyle: TextStyle(
//                                   fontFamily: 'SF UI Display',
//                                   fontSize: 16,
//                                   color: Colors.white),
//                             );
