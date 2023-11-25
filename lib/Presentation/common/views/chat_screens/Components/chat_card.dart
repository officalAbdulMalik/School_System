import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_system/Models/Chats/chat_model.dart';
import 'package:school_system/Presentation/common/resources/Extension/extension.dart';
import 'package:school_system/Presentation/common/views/chat_screens/chat_details_screen.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';

class CustomCards extends StatelessWidget {
  const CustomCards({super.key,this.model,this.docID});

 final String? docID;


  final ChatsUsers? model;

  @override
  Widget build(BuildContext context) {
    return   InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ChatDetailsScreen(
              docId: docID,
              model: model,
            );
          },
        ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 8.sp),
        height: 70.h,
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 46.sp,
              height: 46.sp,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: model?.profileImage !=null
                      ? NetworkImage(model?.profileImage??"")
                      : const AssetImage('images/prof.png') as ImageProvider,
                  fit: BoxFit.fill,
                ),
                shape: OvalBorder(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: FutureBuilder(
                future: getLastChat(docID!),
                builder: (context,snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: MyText(
                                '${model!.firstName} ${model!.lastName} ',
                                color: Color(0xFF000600),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            const Flexible(
                              child: MyText(
                                "......",
                                textAlign: TextAlign.right,
                                color: Color(0xFF9CA3AF),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: MyText(
                            "",
                            color: Color(0xFF6B7280),
                            fontSize: 12,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    );
                  }
                  else{
                    var lastChatData =
                    snapshot.data!.data() as Map<String, dynamic>;
                    String? lastMessage = lastChatData['message'];
                    Timestamp? timestamp = lastChatData['time_tempt'] as Timestamp;
                    DateTime lastTime = timestamp.toDate();
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: MyText(
                                '${model!.firstName} ${model!.lastName} ',
                                color: Color(0xFF000600),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Flexible(
                              child: MyText(
                                lastTime.toPkTime??"",
                                textAlign: TextAlign.right,
                                color: const Color(0xFF9CA3AF),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: MyText(
                            lastMessage??"",
                            color: const Color(0xFF6B7280),
                            fontSize: 12,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    );
                  }

                }
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<DocumentSnapshot> getLastChat(String userId) async {
    return FirebaseFirestore.instance
        .collection('Chat')
        .doc(userId)
        .collection('chats')
        .orderBy('time_tempt')
        .limit(1)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first;
      } else {
        return querySnapshot.docs.first;
      }
    });
  }

}
