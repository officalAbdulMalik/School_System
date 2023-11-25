import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowStarsImage extends StatelessWidget {
  const ShowStarsImage({super.key,this.imageUrl,this.height,this.width});


  final String? imageUrl;
 final double? height;
  final double? width;


  @override
  Widget build(BuildContext context) {
    return   SizedBox(
      height: height,
        width: width,
        child: Image.asset(imageUrl!,fit: BoxFit.contain,));
  }
}
