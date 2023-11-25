import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Models/Chats/chat_model.dart';
import 'package:school_system/Presentation/common/views/chat_screens/Components/chat_card.dart';
import 'package:school_system/Presentation/common/views/chat_screens/slect_user_for_chat.dart';
import 'package:school_system/Presentation/utils/app_images.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_time_picker.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';
import 'package:school_system/Presentation/utils/custom_widget/search_text_field.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';

import '../../../utils/colors.dart';
import 'chat_details_screen.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();

  TextEditingController textEditingController = TextEditingController();

  List teachers = [
    'john',
    'preva',
    'marcio',
    'zashni',
    'tebro',
  ];

  List teacherProfsion = [
    'Hod',
    'Constructor',
    'Math teacher',
    'English Teacher',
    'IT Teacher',
  ];
  List check = [
    1,
    0,
    0,
    3,
    0,
  ];
}

class _ChatScreenState extends State<ChatScreen> {
  String? userID = LoginApiShadePreference.preferences!.getString('user_id');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 80.sp),
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SelectUserForChat()));
          },
          child: const Icon(Icons.add),
        ),
      ),
      resizeToAvoidBottomInset: false,
      // backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: MyText(
                  'Chats',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: MyText(
                  'View your all chats here.',
                  color: const Color(0xFF6B7280),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: MyText(
              //     'Personal Chats',
              //     color: Colors.black,
              //     fontSize: 16,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
              SearchTextField(
                filledColor: kContainerColor,
                controller: widget.textEditingController, hintText: 'Search',
                callBack: (val) {},

                // decoration: textFieldIconDecoration(
                //     Icons.alternate_email, 'service@gmail.com', null),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 0.85.sh,
                width: 1.sw,
                child: StreamBuilder(
                  stream:
                      FirebaseFirestore.instance.collection('Chat').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    List<QueryDocumentSnapshot<Map<String, dynamic>>>
                        filteredList = snapshot.data!.docs
                            .where((item) => item.id.contains(userID ?? ""))
                            .toList();
                    print("here is lenght ${filteredList.length}");

                    return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        List<QueryDocumentSnapshot> chatDocuments =
                            snapshot.data!.docs;

                        var userData =
                            chatDocuments[index].data() as Map<String, dynamic>;

                        ChatsUsers chats = ChatsUsers.fromMap(userData);
                        String docID = snapshot.data!.docs[index].id;
                        return CustomCards(docID: docID,model: chats);
                        // return ChatCard();

                        // String name = userData['firstName'] ?? "";
                        // String lastName = userData['lastName'] ?? "";
                        // String imageUrl = userData['profileImage'] ?? "";
                        // String type = userData['user_type'] ?? "";


                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          thickness: 1.sp,
                          color: kDividerColor,
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



//    return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: kPrimaryColor,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 10.0, right: 10),
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 20,
//               ),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Search Teachers',
//                   style: GoogleFonts.acme(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Container(
//                 padding: EdgeInsets.only(left: 10),
//                 height: 55,
//                 width: 340,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                     hintText: 'Search',
//                     hintStyle: TextStyle(color: Colors.black, fontSize: 12),
//                     border: InputBorder.none,
//                     prefixIcon: Icon(Icons.search),
//                   ),
//
//                   cursorColor: kPrimaryColor,
//                   // decoration: textFieldIconDecoration(
//                   //     Icons.alternate_email, 'service@gmail.com', null),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               SizedBox(
//                 height: 500,
//                 width: 600,
//                 child: ListView.separated(
//                     itemBuilder: (context, index) {
//                       return Card(
//                         child: Container(
//                           height: 80,
//                           width: 400,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: ListTile(
//                             leading: const CircleAvatar(
//                               radius: 35,
//                               backgroundImage: AssetImage('images/prof.png'),
//                             ),
//                             title: Text(
//                               widget.teachers[index],
//                               style: GoogleFonts.acme(
//                                 color: Colors.black,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                             subtitle: Text(
//                               widget.teacherProfsion[index],
//                               style: GoogleFonts.acme(
//                                 color: Colors.black,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                             trailing: SizedBox(
//                               height: 80,
//                               width: 90,
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: Container(
//                                       height: 45,
//                                       width: 45,
//                                       decoration: const BoxDecoration(
//                                         color: Colors.blue,
//                                         shape: BoxShape.circle,
//                                       ),
//                                       child: InkWell(
//                                         onTap: () async {
//                                           Navigator.push(context,
//                                               MaterialPageRoute(
//                                             builder: (context) {
//                                               return ChatDetailsScreen();
//                                             },
//                                           ));
//                                         },
//                                         child: const Icon(
//                                           Icons.wechat_sharp,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                     separatorBuilder: (context, index) {
//                       return SizedBox(
//                         height: 10,
//                       );
//                     },
//                     itemCount: 5),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
