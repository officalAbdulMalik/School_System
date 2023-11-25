import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_system/Presentation/utils/custom_widget/show_star_image.dart';
import 'my_text.dart';

class CustomRowWidget extends StatelessWidget {
 final String text1;
 final String text2;
 final int? size;
 final String? image;
  final int? flex;
 final  bool? dotButton;
 final bool? imageIs;
 final double? height;
 final double? width;

  const CustomRowWidget(
      {Key? key,
      required this.text1,
      required this.text2,
      this.flex,
      this.dotButton,
      this.imageIs,
      this.size,
      this.image,
     this.height,
     this.width,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: flex ?? 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                text1,
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: 6.sp,
              ),
              MyText(
                text2,
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              )
            ],
          ),
        ),
        Expanded(
          child: dotButton == null
              ? Align(
                  alignment: Alignment.topRight,
                  child: ShowStarsImage(
                    width: width ??86,
                    height: height??56,
                    imageUrl: image,
                  ))
              : imageIs == true
                  ? const Icon(Icons.more_vert)
                  : const SizedBox(),
        ),
      ],
    );
  }
}
