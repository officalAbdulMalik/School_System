import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/views/utils/app_images.dart';
import 'package:school_system/views/utils/custom_widget/my_text.dart';

import '../utils/colors.dart';
import 'chat_details_screen.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: MyText(
                  'Chats',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: MyText(
                  'View your all chats here.',
                  color: Color(0xFF6B7280),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              Container(
                padding: EdgeInsets.all(3.sp),
                margin: EdgeInsets.symmetric(horizontal: 10.sp),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(color: Colors.grey.withAlpha(50), blurRadius: 5)
                ]),
                height: 62.sp,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(AppImages.message),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: MyText(
                                'Personal Chats',
                                color: Color(0xFF3DAEF5),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(AppImages.groupChat),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: MyText(
                                'Group Chats',
                                color: Color(0xFF3DAEF5),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(AppImages.publicList),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: MyText(
                                'Public Lists',
                                color: Color(0xFF3DAEF5),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: MyText(
                  'Personal Chats',
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIconConstraints: BoxConstraints(
                      maxWidth: 100.sp,
                      maxHeight: 100.sp,
                    ),
                    isCollapsed: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8.sp, vertical: 10.sp),
                    filled: true,
                    fillColor: Color(0xFFF3F4F6),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 12),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.transparent)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.transparent)),
                    prefixIcon: Icon(Icons.search),
                  ),

                  cursorColor: kPrimaryColor,
                  // decoration: textFieldIconDecoration(
                  //     Icons.alternate_email, 'service@gmail.com', null),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 500,
                width: 600,
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          Navigator.push(context,
                                              MaterialPageRoute(
                                            builder: (context) {
                                              return ChatDetailsScreen();
                                            },
                                          ));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.sp, vertical: 8.sp),
                          height: 62.sp,
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
                                    image: AssetImage('images/prof.png'),
                                    fit: BoxFit.fill,
                                  ),
                                  shape: OvalBorder(),
                                ),
                              ),
                              const SizedBox(width: 16),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: MyText(
                                              'Selina Madav',
                                              color: Color(0xFF000600),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Flexible(
                                            child: MyText(
                                              '9.18 AM',
                                              textAlign: TextAlign.right,
                                              color: Color(0xFF9CA3AF),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: MyText(
                                        'Will you able to join tomorrow ?',
                                        color: Color(0xFF6B7280),
                                        fontSize: 12,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 20.sp,
                                height: 20.sp,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: widget.check[index] == 0
                                        ? Colors.transparent
                                        : const Color(0xff3DAEF5)),
                                child: Center(
                                  child: widget.check[index] == 0
                                      ? SvgPicture.asset(AppImages.doubleCheck)
                                      : MyText(
                                          widget.check[index].toString(),
                                          color: Colors.white,
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Container(
                        color: Color(0xff6B7280).withOpacity(0.04),
                        height: 1,
                      );
                    },
                    itemCount: 5),
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
