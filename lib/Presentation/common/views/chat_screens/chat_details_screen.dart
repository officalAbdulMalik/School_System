import 'package:chat_bubbles/bubbles/bubble_special_two.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Presentation/utils/app_images.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';

import '../../../../models/chat_model.dart';
import '../../../utils/colors.dart';

class ChatDetailsScreen extends StatefulWidget {
  const ChatDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  List<ChatModel> list = [
    ChatModel(message: 'Hello, How are you', isMe: true, userImage: ''),
    ChatModel(message: 'Are there any new updates', isMe: true, userImage: ''),
    ChatModel(message: "Hello, I'm good", isMe: false, userImage: ''),
    ChatModel(
        message: 'I will let you know when there is any problem',
        isMe: false,
        userImage: ''),
  ];

  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
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
                      Container(
                        height: 32.sp,
                        width: 32.sp,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/prof.png'),
                            fit: BoxFit.fill,
                          ),
                          shape: OvalBorder(),
                        ),
                      ),
                      SizedBox(
                        width: 4.sp,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: MyText(
                                    'Jack Nickolsan',
                                    fontSize: 14.sp,
                                  )),
                            ),
                            const Expanded(
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: MyText(
                                    'Teacher',
                                  )),
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
          SizedBox(
            height: 70.sp,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 50.sp,
                  width: 50.sp,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withAlpha(60), blurRadius: 4),
                      ]),
                  child: Center(
                    child: SvgPicture.asset(AppImages.phoneIcon),
                  ),
                ),
                SizedBox(
                  width: 16.sp,
                ),
                Container(
                  height: 48.sp,
                  width: 48.sp,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withAlpha(60), blurRadius: 4),
                      ]),
                  child: Center(
                    child: SvgPicture.asset(AppImages.videoCallIcon),
                  ),
                ),
                SizedBox(
                  width: 16.sp,
                ),
                Container(
                  height: 48.sp,
                  width: 48.sp,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withAlpha(60), blurRadius: 4),
                      ]),
                  child: Center(
                    child: SvgPicture.asset(AppImages.calenderIcon),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15.sp),
              //  reverse: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return list[index].isMe
                    ? getSenderMessageCard(index)
                    : receiver(index);
              },
            ),
          ),
          Container(
            // padding: EdgeInsets.symmetric(horizontal: 10.sp,vertical: 10.sp),
            margin: EdgeInsets.only(left: 16.sp, right: 16.sp, bottom: 29.sp),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.sp),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withAlpha(70),
                      blurRadius: 5,
                      offset: Offset(3, 5))
                ]),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.photo,
                        color: Color(0xff6B7280))),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.mic, color: Color(0xff6B7280))),
                Expanded(
                  child: TextField(
                    controller: messageController,
                    maxLines: null,
                    decoration: InputDecoration(
                        hintText: 'Write you message',
                        border: InputBorder.none),
                  ),
                ),
                SvgPicture.asset(AppImages.sendIcon),
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
      )),
    );
  }

  receiver(int index) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(10.sp),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.sp),
                    bottomLeft: Radius.circular(15.sp),
                    bottomRight: Radius.circular(15.sp),
                  ),
                  color: Color(0xff3DAEF5)),
              child: MyText(
                list[index].message,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            width: 40.sp,
            height: 40.sp,
            decoration: const ShapeDecoration(
              image: DecorationImage(
                image: AssetImage('images/prof.png'),
                fit: BoxFit.fill,
              ),
              shape: OvalBorder(),
            ),
          ),
        ],
      ),
    );
  }

  getSenderMessageCard(int index) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.sp,
            height: 40.sp,
            decoration: const ShapeDecoration(
              image: DecorationImage(
                image: AssetImage('images/prof.png'),
                fit: BoxFit.fill,
              ),
              shape: OvalBorder(),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(10.sp),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15.sp),
                    bottomLeft: Radius.circular(15.sp),
                    bottomRight: Radius.circular(15.sp),
                  ),
                  color: Colors.grey.withOpacity(0.15)),
              child: MyText(list[index].message),
            ),
          ),
          Spacer(),
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
