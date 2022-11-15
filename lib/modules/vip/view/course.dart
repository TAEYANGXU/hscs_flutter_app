import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'section.dart';
import '../model/course.dart';
import 'package:hscs_flutter_app/extension/loading_icon.dart';

class VipCourseView extends StatelessWidget {
  VipCourseView({Key? key, this.categoryData}) : super(key: key);
  CategoryData? categoryData;

  List<Widget> getCourseList(List<CourseList> list) {
    List<Widget> courseList = [];
    for (int i = 0; i < list.length; i++) {
      CourseList data = list[i];
      courseList.add(
        GestureDetector(
          onTap: (){
            print("object");
          },
          child: Container(
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Adapt.px(175),
                  height: Adapt.px(112),
                  margin: EdgeInsets.only(
                      left: Adapt.px(15), top: Adapt.px(10), bottom: Adapt.px(10)),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: CacheImage(
                    imageUrl: data.coverImage,
                    width: Adapt.px(175),
                    height: Adapt.px(112),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: Adapt.px(15),),
                    Container(
                      height: Adapt.px(45),
                      width: Adapt.screenW() - Adapt.px(175) - Adapt.px(50),
                      margin: EdgeInsets.only(left: Adapt.px(15)),
                      child: Text(data.courseTitle ?? "",maxLines: 2,style: TextStyle(fontSize:TextSize.big,color: AppColors.text,fontWeight: FontWeight.w600),),
                    ),
                    Container(
                      height: Adapt.px(80),
                      width: Adapt.screenW() - Adapt.px(175) - Adapt.px(50),
                      margin: EdgeInsets.only(left: Adapt.px(15)),
                      child: Text(data.description ?? "",maxLines: 4,),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      );
    }
    return courseList;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (categoryData == null) {
      return Container();
    }
    return Container(
      child: Column(
        children: [
          VipSectionView(
            title: categoryData!.categoryTitle ?? "",
            icon: "vip/vip_course_icon",
            router: "",
            params: {},
          ),
          categoryData!.list!.isNotEmpty
              ? Column(
                  children: getCourseList(categoryData!.list!),
                )
              : Container(),
        ],
      ),
    );
  }
}
