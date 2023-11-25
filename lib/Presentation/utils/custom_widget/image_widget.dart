import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_system/Presentation/utils/colors.dart';

class CachedImage extends StatelessWidget {
  final String url;
  final double? scale;
  final double? radius;
  final bool? isCircle;
  final double? containerRadius;
  final double? bottomRadius;
  final double? topRadius;
  final BoxFit? fit;
  final double? width;
  final double? height;

  const CachedImage({
    super.key,
    required this.url,
    this.scale = 1,
    this.radius = 50,
    this.isCircle = true,
    this.containerRadius = 0,
    this.topRadius,
    this.bottomRadius,
    this.fit = BoxFit.fill,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => isCircle!
          ? Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(
            color: kPrimaryColor,
          ),
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: CircularProgressIndicator(
            color: kPrimaryColor,
          ),
        ),
      )
          : Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(containerRadius!),
        ),
        child: const Center(
          child: CircularProgressIndicator(
            color: kPrimaryColor,
          ),
        ),
      ),
      errorWidget: (context, url, error) {
        return isCircle!
            ? CircleAvatar(
            radius: radius,
            backgroundImage: const NetworkImage(
              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"
            ))
            : Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.network(
            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
            height: height ?? 0.30.sh,
            width: width ?? 1.sw,
          ),
        );
      },
      imageBuilder: (context, imageProvider) => isCircle!
          ? CircleAvatar(
        radius: radius,
        backgroundImage: imageProvider,
      )
          : ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(topRadius ?? containerRadius!),
          topLeft: Radius.circular(topRadius ?? containerRadius!),
          bottomLeft: Radius.circular(bottomRadius ?? containerRadius!),
          bottomRight: Radius.circular(bottomRadius ?? containerRadius!),
        ),
        child: Image(
          image: imageProvider,
          width: width,
          height: height,
          fit: fit,
        ),
      ),
    );
  }
}
