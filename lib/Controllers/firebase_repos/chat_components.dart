import 'dart:ffi';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_system/Controllers/Cubits/CommonCubit/create_chat_cubit.dart';
import 'package:school_system/Controllers/Services/downloder_repos.dart';
import 'package:school_system/Presentation/common/views/chat_screens/show_chat_file.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ChatComponents {
  Future<void> pickFile(String docID, BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type:
          FileType.custom, // You can specify the type of file you want to pick
      allowedExtensions: [
        'pdf',
        'doc',
        'docx',
        'txt',
        'xls', // Excel workbook
        'xlsx'
      ], // Add the extensions you want to allow
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      context
          .read<CreateChatCubit>()
          .addFileInChat(docID, file.name, file.path!);
      // You can use the file variable to access the selected file
      print('Picked file: ${file.name}');
      print('File path: ${file.path}');
      print('File size: ${file.size}');
    } else {
      // User canceled the file picker
      print('No file selected');
    }
  }

  Future pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type:
          FileType.custom, // You can specify the type of file you want to pick
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png',
      ], // Add the extensions you want to allow
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      // You can use the file variable to access the selected file
      print('Picked file: ${file.name}');
      print('File path: ${file.path}');
      print('File size: ${file.size}');
      return result;
    } else {
      return null;
      // User canceled the file picker
      print('No file selected');
    }
  }

  receiver(int index, List data, BuildContext context, String userImage) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          data[index]['file_path'].contains('https://')
              ? _isImageFile(data[index]['message']) == true
                  ? InkWell(
                      onTap: () {
                        print('data >>>>>>');
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return ShowFullImage(
                              imageUrl: data[index]['file_path'],
                            );
                          },
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(10.sp),
                            image: DecorationImage(
                                image: NetworkImage(data[index]['file_path']),
                                fit: BoxFit.cover)),
                        height: 100.h,
                        width: 200,
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.sp),
                            bottomLeft: Radius.circular(15.sp),
                            bottomRight: Radius.circular(15.sp),
                          ),
                          color: const Color(0xff3DAEF5)),
                      child: Row(
                        children: [
                          MyText(
                            data[index]['message'] ?? "",
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          InkWell(
                            onTap: () async {
                              // if (!await launchUrl(
                              //     Uri.parse(data[index]['file_path']))) {
                              //   throw Exception('Could not launch ');
                              // }

                              // await Downloader.startDownload(
                              //   data[index]['message'],
                              // );
                              // Navigator.push(context, MaterialPageRoute(
                              //   builder: (context) {
                              //     return FileDownloaderScreen();
                              //   },
                              // ));
                            },
                            child: data[index]['download'] == 'false'
                                ? const Icon(
                                    Icons.download,
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    Icons.download_done,
                                    color: Colors.white,
                                  ),
                          ),
                        ],
                      ),
                    )
              : Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.all(10.sp),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.sp),
                          bottomLeft: Radius.circular(15.sp),
                          bottomRight: Radius.circular(15.sp),
                        ),
                        color: const Color(0xff3DAEF5)),
                    child: MyText(
                      data[index]['message'] ?? "",
                    ),
                  ),
                ),
          SizedBox(
            width: 7.w,
          ),
          Container(
            width: 40.sp,
            height: 40.sp,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: userImage!.isNotEmpty
                    ? NetworkImage(userImage!)
                    : AssetImage('images/prof.png') as ImageProvider,
                fit: BoxFit.fill,
              ),
              shape: OvalBorder(),
            ),
          ),
        ],
      ),
    );
  }

  bool _isImageFile(String url) {
    // Check if the URL ends with a common image file extension
    return url.endsWith('jpg') ||
        url.endsWith('jpeg') ||
        url.endsWith('png') ||
        url.endsWith('gif') ||
        url.endsWith('bmp') ||
        url.endsWith('svg') ||
        url.endsWith('tiff') ||
        url.endsWith('webp');
  }

  getSenderMessageCard(
      int index, List data, String userImage, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.sp,
            height: 40.sp,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: userImage.isNotEmpty
                    ? NetworkImage(userImage)
                    : const AssetImage('images/prof.png') as ImageProvider,
                fit: BoxFit.fill,
              ),
              shape: const OvalBorder(),
            ),
          ),
          SizedBox(
            width: 7.sp,
          ),
          data[index]['file_path'].contains('https://')
              ? _isImageFile(data[index]['message']) == true
                  ? InkWell(
                      onTap: () {
                        print('data >>>>>>');
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return ShowFullImage(
                              imageUrl: data[index]['file_path'],
                            );
                          },
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: chatBubble),
                            borderRadius: BorderRadius.circular(10.sp),
                            image: DecorationImage(
                                image: NetworkImage(data[index]['file_path']),
                                fit: BoxFit.cover)),
                        height: 100.h,
                        width: 200,
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.sp),
                            bottomLeft: Radius.circular(15.sp),
                            bottomRight: Radius.circular(15.sp),
                          ),
                          color: chatBubble),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              // await Downloader.startDownload(
                              //   data[index]['message'],
                              // );
                              // Navigator.push(context, MaterialPageRoute(
                              //   builder: (context) {
                              //     return FileDownloaderScreen();
                              //   },
                              // ));
                            },
                            child: data[index]['download'] == 'false'
                                ? const Icon(
                                    Icons.download,
                                    color: Colors.black,
                                  )
                                : const Icon(
                                    Icons.download_done,
                                    color: Colors.black,
                                  ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          MyText(
                            data[index]['message'] ?? "",
                          ),

                          // InkWell(
                          //   onTap: () async {
                          //     await Downloader.startDownload(
                          //       data[index]['message'],
                          //     );
                          //     // Navigator.push(context, MaterialPageRoute(
                          //     //   builder: (context) {
                          //     //     return ShowFile(
                          //     //       url: data[index]['file_path'],
                          //     //     );
                          //     //   },
                          //     // ));
                          //   },
                          //   child: data[index]['download'] == 'false'
                          //       ? const Icon(
                          //           Icons.download,
                          //           color: Colors.white,
                          //         )
                          //       : const Icon(
                          //           Icons.download_done,
                          //           color: Colors.white,
                          //         ),
                          // ),
                        ],
                      ),
                    )
              : Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.all(10.sp),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.sp),
                          bottomLeft: Radius.circular(15.sp),
                          bottomRight: Radius.circular(15.sp),
                        ),
                        color: const Color(0xff3DAEF5)),
                    child: MyText(
                      data[index]['message'] ?? "",
                    ),
                  ),
                ),
          // Expanded(
          //   flex: 3,
          //   child: Container(
          //     padding: EdgeInsets.all(10.sp),
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.only(
          //           topRight: Radius.circular(15.sp),
          //           bottomLeft: Radius.circular(15.sp),
          //           bottomRight: Radius.circular(15.sp),
          //         ),
          //         color: Colors.grey.withOpacity(0.15)),
          //     child: MyText(data[index]['message'] ?? ""),
          //   ),
          // ),
          Spacer(),
        ],
      ),
    );
  }
}

class ShowFullImage extends StatelessWidget {
  const ShowFullImage({Key? key, this.imageUrl}) : super(key: key);

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Image.network(
              imageUrl!,
              fit: BoxFit.cover,
              width: 1.sw,
            ),
            Positioned(
                top: 20.sp,
                left: 10.sp,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
