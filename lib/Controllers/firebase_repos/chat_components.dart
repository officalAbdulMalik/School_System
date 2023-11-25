import 'package:school_system/Presentation/utils/custom_widget/image_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_system/Controllers/Cubits/CommonCubit/create_chat_cubit.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';


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
                      child: CachedImage(
                        containerRadius: 10.sp,
                        height: 100.h,
                        width: 200.w,
                        url: data[index]['file_path'],isCircle: false,))
                  : Container(
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15.sp),
                            bottomLeft: Radius.circular(15.sp),
                            bottomRight: Radius.circular(15.sp),
                          ),
                          color: kPrimaryColor),
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
          SizedBox(
            width: 40.sp,
            height: 40.sp,
            child: CachedImage(url: userImage),
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
          SizedBox(
            width: 40.sp,
            height: 40.sp,
            child: CachedImage(url: userImage),
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
                      child: CachedImage(
                        containerRadius: 10.sp,
                        height: 100.h,
                        width: 200.w,
                        url: data[index]['file_path'],
                        isCircle: false,
                      )
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
           CachedImage(
             height: 1.sh,
             isCircle: false,
             url:
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
