import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/extension/loading_icon.dart';
import '../model/home_teacher.dart';

class TeacherHeaderView extends StatefulWidget {
  TeacherHeaderView({Key? key, this.teacherData}) : super(key: key);
  TeacherData? teacherData;

  _TeacherHeaderViewState createState() => _TeacherHeaderViewState();
}

class _TeacherHeaderViewState extends State<TeacherHeaderView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (widget.teacherData == null) {
      return Container();
    }
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'lib/assets/image/home/master_bg.png',
                  ),
                  fit: BoxFit.cover)),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.only(left: Adapt.px(15)),
                  // color: Colors.red,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Adapt.px(95),
                      ),
                      Text(
                        widget.teacherData!.realName ?? "",
                        style: const TextStyle(
                            fontSize: TextSize.larger,
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: Adapt.px(5)),
                        width: Adapt.px(90),
                        height: Adapt.px(25),
                        decoration: BoxDecoration(
                            color: HexColor("#FFF7E9"),
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                                width: 1, color: HexColor("#D7A859"))),
                        child: Center(
                          child: Text(
                            widget.teacherData!.title ?? "",
                            style: const TextStyle(fontSize: TextSize.main1),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: Adapt.px(5)),
                        width: Adapt.screenW() * 0.6,
                        // height: Adapt.px(80),
                        child: Text(
                          widget.teacherData!.des ?? "",
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: TextSize.main),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: Adapt.px(0)),
                      width: Adapt.px(139),
                      height: Adapt.px(182),
                      child: CacheImage(
                        imageUrl: widget.teacherData!.posterImg,
                        width: Adapt.px(139),
                        height: Adapt.px(182),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        // Container(
        //   margin: EdgeInsets.only(top: Adapt.px(246)),
        //   width: double.infinity,
        //   height: Adapt.px(10),
        //   color: AppColors.line,
        // )
      ],
    );
  }
}
