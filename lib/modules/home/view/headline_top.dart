
import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import '../../../style/index.dart';
import '../model/home_headline.dart';
import 'package:hscs_flutter_app/global_config.dart';

class HeadLineTopView extends StatefulWidget{
  HeadLineTopView({Key? key,this.headLineList}) : super(key: key);
  List<ListData>? headLineList = [];

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HeadLineTopViewState();
  }
}

class _HeadLineTopViewState extends State<HeadLineTopView> {

  List<Widget> items(List<ListData> headLineList)
  {
    List<Widget> itemList = [];
    for (var i = 0; i < headLineList.length; i++) {
      var model = headLineList[i];
      itemList.add(
          GestureDetector(
            onTap: () async {
              print("1");
              await GlobalConfig.channel.invokeMethod("lyitp://diqiu/webview",{"url":model.detailLink});
            },
            child: Container(
              padding: EdgeInsets.only(left: Adapt.px(15),right: Adapt.px(15)),
              // color: Colors.red,
              height: Adapt.px(45),
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  loadLocalImage("home/tou_${i+1}_icon",width: Adapt.px(8),height: Adapt.px(11)),
                  SizedBox(width: Adapt.px(5),),
                  Container(
                    width: Adapt.screenW() - Adapt.px(80),
                    child: Text(model.title ?? "",style: const TextStyle(fontSize: TextSize.main1,fontWeight: FontWeight.w500),maxLines: 1,overflow: TextOverflow.ellipsis,),
                  )
                ],
              ),
            ),
          )
      );
    }
    return  itemList;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // height: Adapt.px(40),
            // width: double.infinity,
            padding: EdgeInsets.only(top: Adapt.px(15),left: Adapt.px(15)),
            child: loadLocalImage("home/tou_icon",width: Adapt.px(41),height: Adapt.px(17)),
          ),
          Container(
            margin: EdgeInsets.all(Adapt.px(15)),
            width: Adapt.screenW() - Adapt.px(20),
            height: widget.headLineList!.length * Adapt.px(45),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(colors: [HexColor("#FCF0F3"),HexColor("#FFFFFF")],begin: Alignment.topRight,end: Alignment.bottomRight),
                shape: BoxShape.rectangle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(20),
                    offset: const Offset(0, 1),
                    blurRadius: 10,
                    spreadRadius: 1,
                  )
                ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items(widget.headLineList!),
            ),
          )
        ],
      ),
    );
  }
}