
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_system/Models/participations.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/image_widget.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';

class MultiItemPicker extends StatefulWidget {
  final void Function(List) list;
  final List<Participation>? getList;
  final String hintText;
  final double? hMar;
  final bool? isParentSide;
  const MultiItemPicker({
    super.key,
    required this.list,
    required this.getList,
    required this.hintText,
    required this.isParentSide,
    this.hMar = 0,
  });

  @override
  State<MultiItemPicker> createState() => _MultiItemPickerState();
}

class _MultiItemPickerState extends State<MultiItemPicker> {
  List list = [];
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: widget.hMar!).r,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ).r,
      decoration: BoxDecoration(
        color: kContainerColor,
        borderRadius: BorderRadius.circular(10).r,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 13,
        ).r,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isClicked = !isClicked;
                });
                widget.list(list);
              },
              behavior: HitTestBehavior.opaque,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  list.isEmpty
                      ? MyText(
                    widget.hintText,
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  )
                      : Flexible(
                    flex: 2,
                    child: SizedBox(
                      width: 1.sw,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: 85.w,
                                  height: 26.h,
                                  margin:
                                  const EdgeInsets.only(right: 10).r,
                                  decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius:
                                    BorderRadius.circular(8).r,
                                  ),
                                  child: Center(
                                    child: MyText(
                                      list[index].firstName??"",
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 1,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      list.removeAt(index);
                                    });
                                    widget.list(list);
                                  },
                                  behavior: HitTestBehavior.opaque,
                                  child: Container(
                                    width: 15.w,
                                    height: 15.w,
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.close_rounded,
                                        color: Colors.white,
                                        size: 10.r,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  isClicked == false
                      ? Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                        size: 28.r,
                      )
                      : Icon(
                        Icons.arrow_drop_up,
                        color: kPrimaryColor,
                        size: 28.r,
                      ),
                ],
              ),
            ),
            isClicked
                ? Container(
              margin: const EdgeInsets.symmetric(vertical: 8).r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10).r,
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.getList!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                     widget.isParentSide != true? list.contains(widget.getList![index])
                          ? list.remove(widget.getList![index])
                          : list.add(widget.getList![index]): list.contains(widget.getList![index])
                         ? list.remove(widget.getList![index])
                         : list = [widget.getList![index]];
                      widget.list(list);
                      setState(() {});
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10)
                          .r,
                      margin: const EdgeInsets.symmetric(vertical: 2).r,
                      decoration: BoxDecoration(
                        color: list.contains(widget.getList![index])
                            ?kPrimaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(5).r,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                              height:40.h,
                              width: 40.w,
                              child: CachedImage(url: widget.getList?[index].image??"",height: 30.h,width: 30.w,isCircle: true)),
                          SizedBox(width: 20.w,),
                          MyText(
                            widget.getList?[index].firstName??"",
                          ),
                          Spacer(),
                          Icon(
                            Icons.check_circle_outline_rounded,
                            color: list.contains(widget.getList![index])
                                ? Colors.white
                                : Colors.grey,
                            size: 20.r,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}