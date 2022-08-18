import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/style/index.dart';
import '../model/home_headline.dart';
import 'package:hscs_flutter_app/extension/loading_icon.dart';
import 'section.dart';

class HomeHeadlineView extends StatefulWidget {
  HomeHeadlineView({Key? key, this.list}) : super(key: key);
  List<ListData>? list;

  _HomeHeadlineViewState createState() => _HomeHeadlineViewState();
}

class _HomeHeadlineViewState extends State<HomeHeadlineView> {
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
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: Adapt.px(10),left: Adapt.px(10)),
                      width: Adapt.screenW() - Adapt.px(25 + 120),
                      height: Adapt.px(60),
                      child: Text(data.title!,
                        maxLines: 2,overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: TextSize.main1,color: AppColors.text),
                      ),
                    ),
                    Container(
                      width: Adapt.screenW() - Adapt.px(25 + 120),
                      padding: EdgeInsets.only(top: Adapt.px(10),left: Adapt.px(10)),
                      height: Adapt.px(40),
                      child: Text(data.createdAt!,style: TextStyle(fontSize: TextSize.main,color: AppColors.gredText),),
                    ),
                  ],
                ),
                SizedBox(width: Adapt.px(10),),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
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

  List<Widget> getItems(List<ListData> list) {
    List<Widget> items = [];
    for (var i = 0; i < list.length; i++) {
      ListData data = list[i];
      items.add(item(data, i == list.length -1 ? false : true));
    }
    return items;
  }

  Widget listView(List<ListData> list) {
    return Container(
      margin: EdgeInsets.only(
          top: Adapt.px(10), left: Adapt.px(15), right: Adapt.px(15)),
      height: Adapt.px(330),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Adapt.px(8)),
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              offset: Offset(0, 4),
              blurRadius: 8,
              spreadRadius: 0,
            )
          ]),
      child: Column(
        children: getItems(list),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: [
          HomeSectionView(
            title: "市场解读",
          ),
          listView(widget.list!)
        ],
      ),
    );
  }
}
