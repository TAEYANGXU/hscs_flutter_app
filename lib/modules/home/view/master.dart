import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/style/index.dart';
import '../model/home_model.dart';
import 'package:hscs_flutter_app/extension/loading_icon.dart';

class HomeMasterView extends StatefulWidget {
  HomeMasterView({Key? key, this.chiefComment, this.askTeacher})
      : super(key: key);

  ChiefcommentData? chiefComment;
  AskteacherData? askTeacher;

  _HomeMasterViewState createState() => _HomeMasterViewState();
}

class _HomeMasterViewState extends State<HomeMasterView> {
  Widget masterInfo() {
    return Container(
      // color: Colors.white,
      margin: EdgeInsets.only(
          top: Adapt.px(10), left: Adapt.px(15), right: Adapt.px(15)),
      height: Adapt.px(140),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Adapt.px(5)),
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              offset: Offset(0, 4),
              blurRadius: 8,
              spreadRadius: 0,
            )
          ]),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(top: Adapt.px(10), left: Adapt.px(12)),
                    child: Text(
                      widget.chiefComment?.realName ?? "",
                      style: TextStyle(
                          fontSize: TextSize.s17,
                          fontWeight: FontWeight.bold,
                          color: AppColors.text),
                    ),
                  ),
                  SizedBox(
                    width: Adapt.px(2),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(top: Adapt.px(10), left: Adapt.px(12)),
                    child: Text(
                      widget.chiefComment!.title!,
                      style: TextStyle(
                          fontSize: TextSize.main,
                          fontWeight: FontWeight.bold,
                          color: AppColors.gredText),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    margin:
                        EdgeInsets.only(top: Adapt.px(2), left: Adapt.px(12)),
                    height: Adapt.px(2),
                    width: Adapt.px(20),
                    color: HexColor("#373737"),
                  )
                ],
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin:
                        EdgeInsets.only(top: Adapt.px(8), left: Adapt.px(12)),
                    height: Adapt.px(24),
                    width: Adapt.px(130),
                    decoration: BoxDecoration(
                        color: HexColor("#E8E8E8"),
                        borderRadius: BorderRadius.circular(Adapt.px(12))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.chiefComment!.certificateNo!,
                            textAlign: TextAlign.center)
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    margin:
                        EdgeInsets.only(top: Adapt.px(8), left: Adapt.px(12)),
                    width: Adapt.px(215),
                    child: Text(
                      widget.chiefComment!.des.toString(),
                      style: TextStyle(
                          fontSize: TextSize.small, color: AppColors.gredText),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              )
            ],
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: Adapt.px(5)),
                width: Adapt.px(100),
                height: Adapt.px(130),
                child: CacheImage(
                  imageUrl: widget.chiefComment!.posterImg!,
                  width: Adapt.px(100),
                  height: Adapt.px(130),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildItem(BuildContext context, int index) {
    var teacher = widget.askTeacher!.teacherList![index];
    var name = teacher.realName;
    if(name != null && name.length > 5){
      name = name.substring(0, 4);
    }
    return GestureDetector(
        onTap: () {
          debugPrint("index = $index");
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Adapt.px(10)),
              shape: BoxShape.rectangle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(30),
                  offset: Offset(0, 2),
                  blurRadius: 4,
                  spreadRadius: 0,
                )
              ]),
          height: Adapt.px(85),
          width: Adapt.px(80),
          child: Column(
            children: [
              SizedBox(
                height: Adapt.px(15),
              ),
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Adapt.px(18)),
                ),
                child: teacher.avatar!.trim().isEmpty ? loadLocalImage("mine/mine_default_avatar",width: Adapt.px(36),height: Adapt.px(36)) :
                CacheImage(
                  imageUrl: teacher.avatar ?? "",
                  width: Adapt.px(36),
                  height: Adapt.px(36),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                name!,
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: AppColors.text, fontSize: TextSize.main),
              ),
            ],
          ),
        ));
  }

  List<Widget> getItems() {
    List<Widget> list = [];
    for (var i = 0; i < widget.askTeacher!.teacherList!.length; i++) {
      var icon = widget.askTeacher!.teacherList![i];
      if (i != widget.askTeacher!.teacherList!.length - 1) {
        list.add(SizedBox(
          width: Adapt.px(15),
        ));
      }
      list.add(buildItem(context, i));
    }
    return list;
  }

  Widget masterList() {
    if(widget.askTeacher == null){
      return Container();
    }
    return Container(
        margin: EdgeInsets.only(top: Adapt.px(15)),
        height: Adapt.px(90),
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: getItems(),
          ),
        ));
  }

  Widget titleWidet() {
    return Container(
      padding: EdgeInsets.only(left: Adapt.px(12), top: Adapt.px(5)),
      child: Row(
        children: [
          Text(
            '问理财师',
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: TextSize.larger,
                color: AppColors.text,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: Adapt.px(295),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [titleWidet(), masterInfo(), masterList()],
      ),
    );
  }
}
