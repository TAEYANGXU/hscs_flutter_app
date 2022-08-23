import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/modules/home/model/home_headline.dart';
import 'package:hscs_flutter_app/extension/loading_icon.dart';
import 'section.dart';

class VipColumnView extends StatefulWidget {
  VipColumnView({Key? key, this.columnList}) : super(key: key);
  List<ListData>? columnList;

  _VipColumnViewState createState() => _VipColumnViewState();
}

class _VipColumnViewState extends State<VipColumnView> {
  Widget item(ListData data,bool showLine) {
    return GestureDetector(
      onTap: (){
        var title = data.title!;
        debugPrint("title = $title");
      },
      child: Stack(
        children: [
          Container(
            height: Adapt.px(110),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: Adapt.px(10),left: Adapt.px(15)),
                      width: Adapt.screenW() - Adapt.px(25 + 120),
                      height: Adapt.px(60),
                      child: Text(data.title!,
                        maxLines: 2,overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: TextSize.main1,color: AppColors.text),
                      ),
                    ),
                    Container(
                      width: Adapt.screenW() - Adapt.px(25 + 120),
                      padding: EdgeInsets.only(top: Adapt.px(10),left: Adapt.px(15)),
                      height: Adapt.px(40),
                      child: Text(data.createdAt!,style: TextStyle(fontSize: TextSize.main,color: AppColors.gredText),),
                    ),
                  ],
                ),
                // SizedBox(width: Adapt.px(10),),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: Adapt.px(15)),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6)
                      ),
                      child: data.coverPic!.length > 0 ? CacheImage(imageUrl: data.coverPic!,width: Adapt.px(90),height: Adapt.px(70),) : Container(),
                    )
                  ],
                ) ,
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: Adapt.px(109),left: Adapt.px(10),right: Adapt.px(10)),
            height: showLine ? Adapt.px(0.5) : 0,
            color: AppColors.line,
          )
        ],
      ),
    );
  }

  List<Widget> getItems(List<ListData>? list) {
    if(list == null){
      return [];
    }
    List<Widget> items = [];
    for (var i = 0; i < list!.length; i++) {
      ListData data = list[i];
      items.add(item(data, i == list.length -1 ? false : true));
    }
    return items;
  }

  Widget listView(List<ListData>? list) {
    return Container(
      height: Adapt.px(330),
      child: Column(
        children: getItems(list),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: Adapt.px(8),
            color: AppColors.space,
          ),
          SizedBox(height: Adapt.px(10),),
          VipSectionView(title: "理财头条",icon: "vip/vip_section_3",),
          listView(widget.columnList)
        ],
      ),
    );
  }
}
