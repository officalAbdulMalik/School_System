import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_system/Presentation/BottomBarTeacher/prifile_screen/teacher_add_clases.dart';
import 'package:school_system/Presentation/common/views/shool_addInInfo.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/Presentation/utils/custom_widget/image_widget.dart';
import 'package:school_system/models/get_all_school_model.dart';

class SchoolTiles extends StatelessWidget {
  const SchoolTiles({super.key,this.searchList,this.index});

final List<Schools>? searchList;
final int? index;

  @override
  Widget build(BuildContext context) {

    return  Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius:
        BorderRadius.circular(15.sp),
      ),
      child: ListTile(
        leading: CachedImage(
          height: 15.h,
           width: 15.w,
          radius: 20.sp,
          isCircle: true,
          url: '${searchList![index!].image}',
        ),
        title: Text(
          searchList![index!].schoolName!,
          style: CustomWidgets.textStyle(
              color: Colors.black,
              size: 16,
              weight: FontWeight.w600),
        ),
        subtitle: Text(
          searchList![index!].address!,
          style: CustomWidgets.textStyle(
              color: kDescriptionColor,
              size: 15,
              weight: FontWeight.w500),
        ),
        trailing: SizedBox(
          height: 30,
          width: 30,
          child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SchoolAddInInfo(
                        data: searchList!,
                        index: index!,
                      );
                    },
                  ));
            },
            child: Center(
              child: Icon(
                Icons.add,
                size: 25.sp,
                color: kDescriptionColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
